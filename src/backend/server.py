# Enhanced Python web server for KidsPlay with performance monitoring
# Run with: python -m http.server 8080

import http.server
import socketserver
import webbrowser
import threading
import time
import os
import logging
import json
import psutil
import urllib.parse
from datetime import datetime
from collections import deque, defaultdict

PORT = 8080

# Performance monitoring setup
class PerformanceMonitor:
    def __init__(self):
        self.request_times = deque(maxlen=1000)  # Keep last 1000 requests
        self.slow_requests = deque(maxlen=100)   # Keep last 100 slow requests
        self.endpoint_stats = defaultdict(list)
        self.start_time = time.time()
        
        # System monitoring
        self.cpu_history = deque(maxlen=60)      # 1 minute of CPU data
        self.memory_history = deque(maxlen=60)   # 1 minute of memory data
        
        # Setup logging
        self.setup_logging()
        
        # Start background monitoring
        threading.Thread(target=self.monitor_system, daemon=True).start()
    
    def setup_logging(self):
        # Create logs directory if it doesn't exist
        log_dir = os.path.join(os.path.dirname(__file__), '..', '..', 'logs')
        os.makedirs(log_dir, exist_ok=True)
        
        # Setup performance logger
        self.perf_logger = logging.getLogger('performance')
        self.perf_logger.setLevel(logging.INFO)
        
        # File handler for performance logs
        perf_handler = logging.FileHandler(os.path.join(log_dir, 'server_performance.log'), encoding='utf-8')
        perf_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
        perf_handler.setFormatter(perf_formatter)
        self.perf_logger.addHandler(perf_handler)
        
        # Console handler for immediate feedback
        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.WARNING)  # Only show warnings/errors in console
        console_formatter = logging.Formatter('⚠️  %(asctime)s - %(message)s')
        console_handler.setFormatter(console_formatter)
        self.perf_logger.addHandler(console_handler)
    
    def record_request(self, method, path, response_time, status_code, file_size=0):
        timestamp = datetime.now()
        
        # Record basic stats
        self.request_times.append(response_time)
        endpoint = f"{method} {path}"
        self.endpoint_stats[endpoint].append(response_time)
        
        # Detect slow requests (>500ms)
        if response_time > 0.5:
            slow_request = {
                'timestamp': timestamp.isoformat(),
                'method': method,
                'path': path,
                'response_time': response_time,
                'status_code': status_code,
                'file_size': file_size
            }
            self.slow_requests.append(slow_request)
            
            # Log slow request
            self.perf_logger.warning(f"SLOW REQUEST: {method} {path} took {response_time:.3f}s (size: {file_size} bytes)")
        
        # Log all requests to file
        self.perf_logger.info(f"{method} {path} - {response_time:.3f}s - {status_code} - {file_size}B")
    
    def monitor_system(self):
        """Background thread to monitor system resources"""
        while True:
            try:
                cpu_percent = psutil.cpu_percent(interval=1)
                memory = psutil.virtual_memory()
                
                self.cpu_history.append(cpu_percent)
                self.memory_history.append(memory.percent)
                
                # Alert on high resource usage
                if cpu_percent > 80:
                    self.perf_logger.warning(f"HIGH CPU USAGE: {cpu_percent:.1f}%")
                
                if memory.percent > 80:
                    self.perf_logger.warning(f"HIGH MEMORY USAGE: {memory.percent:.1f}%")
                
            except Exception as e:
                self.perf_logger.error(f"System monitoring error: {e}")
            
            time.sleep(1)
    
    def get_stats(self):
        """Return current performance statistics"""
        now = time.time()
        uptime = now - self.start_time
        
        # Calculate request stats
        avg_response_time = sum(self.request_times) / len(self.request_times) if self.request_times else 0
        requests_per_minute = len([t for t in self.request_times if now - t < 60]) if self.request_times else 0
        
        # System stats
        current_cpu = self.cpu_history[-1] if self.cpu_history else 0
        current_memory = self.memory_history[-1] if self.memory_history else 0
        avg_cpu = sum(self.cpu_history) / len(self.cpu_history) if self.cpu_history else 0
        avg_memory = sum(self.memory_history) / len(self.memory_history) if self.memory_history else 0
        
        return {
            'uptime_seconds': uptime,
            'total_requests': len(self.request_times),
            'avg_response_time_ms': avg_response_time * 1000,
            'requests_per_minute': requests_per_minute,
            'slow_requests_count': len(self.slow_requests),
            'current_cpu_percent': current_cpu,
            'current_memory_percent': current_memory,
            'avg_cpu_percent': avg_cpu,
            'avg_memory_percent': avg_memory,
            'slowest_endpoints': self._get_slowest_endpoints()
        }
    
    def _get_slowest_endpoints(self):
        """Get the 5 slowest endpoints by average response time"""
        endpoint_averages = {}
        for endpoint, times in self.endpoint_stats.items():
            if len(times) >= 3:  # Only consider endpoints with at least 3 requests
                endpoint_averages[endpoint] = sum(times) / len(times)
        
        return sorted(endpoint_averages.items(), key=lambda x: x[1], reverse=True)[:5]

# Global performance monitor
perf_monitor = PerformanceMonitor()

class KidsPlayHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        start_time = time.time()
        
        # Special endpoint for performance stats
        if self.path == '/debug/performance':
            self.send_performance_stats()
            return
        
        # Call parent method
        try:
            super().do_GET()
        except Exception as e:
            perf_monitor.perf_logger.error(f"Error handling GET {self.path}: {e}")
            self.send_error(500, "Internal Server Error")
        finally:
            # Record performance metrics
            end_time = time.time()
            response_time = end_time - start_time
            
            # Get file size if available
            file_size = 0
            try:
                if hasattr(self, 'wfile') and hasattr(self.wfile, 'tell'):
                    file_size = self.wfile.tell()
            except:
                pass
            
            perf_monitor.record_request(
                'GET', 
                self.path, 
                response_time, 
                getattr(self, '_status_code', 200),
                file_size
            )
    
    def send_performance_stats(self):
        """Send performance statistics as JSON"""
        try:
            stats = perf_monitor.get_stats()
            
            # Add recent slow requests
            stats['recent_slow_requests'] = list(perf_monitor.slow_requests)[-10:]  # Last 10
            
            response = json.dumps(stats, indent=2)
            
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(response.encode('utf-8'))
            
        except Exception as e:
            perf_monitor.perf_logger.error(f"Error generating performance stats: {e}")
            self.send_error(500, "Error generating stats")
    
    def log_message(self, format, *args):
        """Override to reduce console spam and use our logger"""
        # Only log errors to console, everything else goes to file
        if "40" in str(args[1]) or "50" in str(args[1]):  # 4xx or 5xx status codes
            perf_monitor.perf_logger.warning(format % args)
    
    def end_headers(self):
        # Store status code for monitoring
        self._status_code = getattr(self, '_status_code', 200)
        
        self.send_header('Cross-Origin-Embedder-Policy', 'cross-origin')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        # Force no cache for development - clear all browser cache
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()
    
    def send_response(self, code, message=None):
        """Override to track status codes"""
        self._status_code = code
        super().send_response(code, message)
    
    def copyfile(self, source, outputfile):
        """Override copyfile to handle connection errors gracefully and monitor transfer speed"""
        start_time = time.time()
        bytes_transferred = 0
        
        try:
            # Monitor file transfer in chunks
            chunk_size = 8192
            while True:
                chunk = source.read(chunk_size)
                if not chunk:
                    break
                outputfile.write(chunk)
                bytes_transferred += len(chunk)
                
                # Check for slow transfers (< 100KB/s)
                elapsed = time.time() - start_time
                if elapsed > 1 and bytes_transferred / elapsed < 100000:  # Less than 100KB/s
                    perf_monitor.perf_logger.warning(
                        f"SLOW TRANSFER: {self.path} - {bytes_transferred/1024:.1f}KB in {elapsed:.1f}s "
                        f"({bytes_transferred/elapsed/1024:.1f}KB/s)"
                    )
                    
        except (ConnectionAbortedError, ConnectionResetError, BrokenPipeError) as e:
            # Client disconnected, log but don't crash
            perf_monitor.perf_logger.info(f"Client disconnected during transfer of {self.path}: {e}")
        except Exception as e:
            perf_monitor.perf_logger.error(f"File transfer error for {self.path}: {e}")
            raise

def start_server():
    # Change to frontend directory to serve files from there
    frontend_dir = os.path.join(os.path.dirname(__file__), '..', 'frontend')
    os.chdir(frontend_dir)
    
    # Log server startup
    perf_monitor.perf_logger.info("KidsPlay server starting up...")
    perf_monitor.perf_logger.info(f"Serving from: {os.getcwd()}")
    perf_monitor.perf_logger.info(f"System RAM: {psutil.virtual_memory().total / (1024**3):.1f}GB")
    perf_monitor.perf_logger.info(f"CPU cores: {psutil.cpu_count()}")
    
    with socketserver.TCPServer(("", PORT), KidsPlayHTTPRequestHandler) as httpd:
        print(f"🎮 KidsPlay server running at http://localhost:{PORT}")
        print("📱 Access via mobile: http://[your-ip]:" + str(PORT))
        print("🔧 For gamepad testing, use Chrome or Edge")
        print("📊 Performance stats: http://localhost:" + str(PORT) + "/debug/performance")
        print("📋 Performance logs: logs/server_performance.log")
        print("⏹️  Press Ctrl+C to stop server")
        
        # Start periodic stats reporting
        def report_stats():
            while True:
                time.sleep(300)  # Report every 5 minutes
                try:
                    stats = perf_monitor.get_stats()
                    perf_monitor.perf_logger.info(
                        f"STATS - Uptime: {stats['uptime_seconds']/3600:.1f}h | "
                        f"Requests: {stats['total_requests']} | "
                        f"Avg Response: {stats['avg_response_time_ms']:.1f}ms | "
                        f"CPU: {stats['current_cpu_percent']:.1f}% | "
                        f"RAM: {stats['current_memory_percent']:.1f}% | "
                        f"Slow requests: {stats['slow_requests_count']}"
                    )
                except Exception as e:
                    perf_monitor.perf_logger.error(f"Stats reporting error: {e}")
        
        threading.Thread(target=report_stats, daemon=True).start()
        
        # Open browser after a short delay
        def open_browser():
            time.sleep(1)
            webbrowser.open(f'http://localhost:{PORT}')
        
        threading.Thread(target=open_browser).start()
        
        try:
            perf_monitor.perf_logger.info("Server started successfully")
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Server stopped by user")
            perf_monitor.perf_logger.info("Server shutdown requested by user")
            
            # Log final stats
            final_stats = perf_monitor.get_stats()
            perf_monitor.perf_logger.info(
                f"FINAL STATS - Runtime: {final_stats['uptime_seconds']/3600:.1f}h | "
                f"Total requests: {final_stats['total_requests']} | "
                f"Slow requests: {final_stats['slow_requests_count']}"
            )
            
            httpd.shutdown()

if __name__ == "__main__":
    start_server()
