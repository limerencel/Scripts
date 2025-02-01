"use strict";

const https = require("https");
const http = require("http");

exports.handler = async (event, context, callback) => {
  const req = JSON.parse(event.toString());
  const path = req.rawPath || "/"; // 使用 rawPath 提取路径

  // 检查是否未提供目标 URL
  if (path === "/") {
    callback(null, {
      isBase64Encoded: false,
      statusCode: 200,
      headers: { "Content-Type": "text/plain" },
      body: "Please enter the link after the /",
    });
    return;
  }

  // 从路径中提取目标 URL（去掉第一个 / 并解码）
  const targetUrl =
    decodeURIComponent(path.slice(1)) +
    (req.queryParameters
      ? `?${new URLSearchParams(req.queryParameters).toString()}`
      : "");

  try {
    const response = await fetchProxy(targetUrl, req);
    callback(null, response);
  } catch (err) {
    callback(null, {
      isBase64Encoded: false,
      statusCode: 500,
      headers: { "Content-Type": "text/plain" },
      body: `Error: ${err.message}`,
    });
  }
};

async function fetchProxy(targetUrl, originalRequest) {
  const isHttps = targetUrl.startsWith("https://");
  const protocol = isHttps ? https : http;

  return new Promise((resolve, reject) => {
    const options = {
      method: originalRequest.requestContext.http.method,
      headers: originalRequest.headers,
    };

    const req = protocol.request(targetUrl, options, (res) => {
      const responseHeaders = {
        ...res.headers,
        "Access-Control-Allow-Origin": "*",
      };
      const chunks = [];

      res.on("data", (chunk) => chunks.push(chunk));
      res.on("end", () => {
        const body = Buffer.concat(chunks).toString("base64");
        resolve({
          isBase64Encoded: true,
          statusCode: res.statusCode,
          headers: responseHeaders,
          body: body,
        });
      });
    });

    req.on("error", reject);

    if (originalRequest.body) {
      req.write(Buffer.from(originalRequest.body, "base64"));
    }
    req.end();
  });
}
