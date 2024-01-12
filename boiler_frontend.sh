#!/bin/bash

touch index.html

echo '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="./style.css" />
  </head>
  <body>
    <script src="./app.js"></script>
  </body>
</html>' > index.html

touch style.css

echo '* {
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}' > style.css

touch app.js
