#!/bin/bash

TOKEN_FILE=".access_token"

store_token() {
    echo "$1" > "$TOKEN_FILE"
    echo "Access token stored successfully."
}

get_stored_token() {
    if [ -f "$TOKEN_FILE" ]; then
        cat "$TOKEN_FILE"
    else
        echo ""
    fi
}

beautify_json() {
    if command -v jq &> /dev/null; then
        echo "$1" | jq '.' 2>/dev/null || echo "$1"
    else
        echo "$1"
    fi
}

test_endpoint() {
    local url="$1"
    local expected_status="$2"
    local method="${3:-GET}"
    local body="$4"
    local use_stored_token="$5"
    local custom_token="$6"

    echo -e "\n🔍 Testing $method $url"

    curl_cmd="curl -s -w '\n%{http_code}' -X $method"

    if [ -n "$body" ]; then
        curl_cmd="$curl_cmd -H 'Content-Type: application/json' -d '$body'"
    fi

    if [ "$use_stored_token" = "true" ]; then
        token=$(get_stored_token)
        if [ -n "$token" ]; then
            curl_cmd="$curl_cmd -H 'Authorization: Bearer $token'"
        else
            echo "⚠️ No stored token found. Proceeding without token."
        fi
    elif [ -n "$custom_token" ]; then
        curl_cmd="$curl_cmd -H 'Authorization: Bearer $custom_token'"
    fi

    curl_cmd="$curl_cmd '$url'"

    output=$(eval $curl_cmd)

    status_code=$(echo "$output" | tail -n1)
    response_body=$(echo "$output" | sed '$d')

    echo -e "\n📊 Status Code: $status_code"
    echo -e "\n📋 Response Body:"
    beautified_response=$(beautify_json "$response_body")
    echo "$beautified_response"

    if [ "$status_code" = "$expected_status" ]; then
        echo -e "\n✅ Success: $url returned status $status_code (expected $expected_status)"
    else
        echo -e "\n❌ Fail: $url returned status $status_code, expected $expected_status"
    fi
}

main_menu() {
    while true; do
        echo -e "\n--- 🌐 API Testing Menu ---"
        echo "1. 🧪 Test an endpoint"
        echo "2. 🔑 Store a new access token"
        echo "3. 👀 View stored access token"
        echo "4. 🚪 Exit"
        read -p "Enter your choice: " choice

        case $choice in
            1)
                read -p "Enter URL: " url
                read -p "Enter expected status code: " status
                read -p "Enter method (default: GET): " method
                method=${method:-GET}
                read -p "Enter body (optional): " body
                read -p "Use stored token? (y/n): " use_stored
                use_stored_token=$([ "$use_stored" = "y" ] && echo "true" || echo "false")
                custom_token=""
                if [ "$use_stored" != "y" ]; then
                    read -p "Enter custom token (optional): " custom_token
                fi
                test_endpoint "$url" "$status" "$method" "$body" "$use_stored_token" "$custom_token"
                ;;
            2)
                read -p "Enter new access token: " new_token
                store_token "$new_token"
                ;;
            3)
                token=$(get_stored_token)
                if [ -n "$token" ]; then
                    echo "Stored token: $token"
                else
                    echo "No token stored."
                fi
                ;;
            4)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}

main_menu
