addEventListener('fetch', event => {
    event.respondWith(handleRequest(event.request))
  })
  
  async function handleRequest(request) {
    const url = new URL(request.url);
    
    if (url.pathname === "/") {
      return new Response("Please enter the link after the /");
    }
    
    const targetUrl = url.pathname.slice(1) + url.search + url.hash;
    
    // Create a new headers object with common browser headers
    const headers = new Headers({
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.5',
      'Referer': targetUrl,
    });
  
    // Copy over original headers that might be important
    for (const [key, value] of request.headers.entries()) {
      if (!headers.has(key)) {
        headers.set(key, value);
      }
    }
  
    const modifiedRequest = new Request(targetUrl, {
      headers: headers,
      method: request.method,
      body: request.body,
      redirect: 'follow'
    });
  
    try {
      const response = await fetch(modifiedRequest);
      
      if (response.status === 403) {
        return new Response('Access Forbidden - The target website rejected the request', { status: 403 });
      }
  
      const modifiedResponse = new Response(response.body, response);
      modifiedResponse.headers.set('Access-Control-Allow-Origin', '*');
      return modifiedResponse;
    } catch (error) {
      return new Response(`Error: ${error.message}`, { status: 500 });
    }
  }