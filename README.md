# API Endpoint Testing Script

## Overview

This Bash script provides a comprehensive tool for testing API endpoints with support for various HTTP methods, token management, and response parsing.

## Prerequisites

- Bash (Unix-like environment)
- `curl` installed
- `jq` (optional, but recommended for JSON beautification)

### Optional Installation of Prerequisites

#### On Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install curl jq
```

#### On macOS (using Homebrew)
```bash
brew install curl jq
```

## Features

- Test API endpoints with various HTTP methods (GET, POST, etc.)
- Support for bearer token authentication
- Token storage and management
- Beautified JSON response output
- Detailed success/failure reporting

## Usage

### Running the Script

1. Make the script executable:
```bash
chmod +x test_endpoints.sh
```

2. Run the script:
```bash
./test_endpoints.sh
```

### Menu Options

1. **Test an endpoint**
   - Enter the URL of the endpoint
   - Specify the expected HTTP status code
   - Choose the HTTP method (defaults to GET)
   - Optionally add a request body
   - Choose to use a stored token or enter a custom token

2. **Store a new access token**
   - Save a bearer token for repeated use across tests

3. **View stored access token**
   - Display the currently stored access token

4. **Exit**
   - Close the application

### Example Workflows

#### Testing a GET Endpoint
1. Choose option 1
2. Enter URL: `https://api.example.com/users`
3. Expected status code: `200`
4. Method: `GET`
5. Use stored token? `y/n`

#### Testing a POST Endpoint with Custom Body
1. Choose option 1
2. Enter URL: `https://api.example.com/users`
3. Expected status code: `201`
4. Method: `POST`
5. Body: `{"name":"John Doe","email":"john@example.com"}`
6. Use stored token? `y/n`

#### Managing Tokens
1. Use option 2 to store a new token
2. Use option 3 to view the current stored token

## Output Explanation

- 🔍 Testing details
- 📊 Status code
- 📋 Beautified response body
- ✅/❌ Success or failure indication

## Troubleshooting

- Ensure `curl` is installed
- Install `jq` for best JSON formatting
- Check network connectivity
- Verify endpoint URLs and tokens

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

MIT License

Copyright (c) 2024 [Your Name or Organization]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Disclaimer

This script is provided as-is. Always review and test thoroughly before using in production environments.
