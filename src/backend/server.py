# Simple Python web server for KidsPlay testing
# Run with: python -m http.server 8080

import http.server
import socketserver
import webbrowser
import threading
import time
import os

PORT = 8080

class KidsPlayHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Cross-Origin-Embedder-Policy', 'cross-origin')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        # Force no cache for development - clear all browser cache
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()
    
    def copyfile(self, source, outputfile):
        """Override copyfile to handle connection errors gracefully"""
        try:
            super().copyfile(source, outputfile)
        except (ConnectionAbortedError, ConnectionResetError, BrokenPipeError):
            # Client disconnected, ignore the error
            pass

def start_server():
    # Change to frontend directory to serve files from there
    frontend_dir = os.path.join(os.path.dirname(__file__), '..', 'frontend')
    os.chdir(frontend_dir)
    
    with socketserver.TCPServer(("", PORT), KidsPlayHTTPRequestHandler) as httpd:
        print(f"🎮 KidsPlay server running at http://localhost:{PORT}")
        print("📱 Access via mobile: http://[your-ip]:" + str(PORT))
        print("🔧 For gamepad testing, use Chrome or Edge")
        print("⏹️  Press Ctrl+C to stop server")
        
        # Open browser after a short delay
        def open_browser():
            time.sleep(1)
            webbrowser.open(f'http://localhost:{PORT}')
        
        threading.Thread(target=open_browser).start()
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Server stopped by user")
            httpd.shutdown()

if __name__ == "__main__":
    start_server()
