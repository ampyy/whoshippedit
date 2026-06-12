#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Cleaning up old processes...${NC}"
# Kill processes by name
pkill -9 -f "dotnet" 2>/dev/null || true
pkill -9 -f "tailwindcss" 2>/dev/null || true

# Explicitly kill anything running on port 5133 (macOS syntax)
lsof -t -i:5133 | xargs -I {} kill -9 {} 2>/dev/null || true
sleep 1

echo -e "${BLUE}Starting Tailwind CSS watch mode...${NC}"
npx tailwindcss -i ./wwwroot/css/input.css -o ./wwwroot/css/site.css --watch &
TAILWIND_PID=$!

echo -e "${GREEN}Starting .NET...${NC}"
# User requested "dotnet simple" instead of watch
dotnet run --environment Development &
DOTNET_PID=$!

# Trap SIGINT (Ctrl+C) to kill the entire process group gracefully
trap "echo 'Stopping dev servers...'; kill -TERM -$$ 2>/dev/null; exit" SIGINT SIGTERM

# Wait for background processes to finish
wait $TAILWIND_PID
wait $DOTNET_PID
