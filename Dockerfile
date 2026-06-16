# ==========================================
# STAGE 1: Compile CSS using Node.js & Tailwind
# ==========================================
FROM node:20-alpine AS css-builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY tailwind.config.js ./
COPY Views ./Views
COPY wwwroot ./wwwroot
RUN npm run build:css

# ==========================================
# STAGE 2: Build & Publish C# Application
# ==========================================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["whoshippedit.csproj", "./"]
RUN dotnet restore "whoshippedit.csproj"
COPY . .
# Copy compiled CSS from Stage 1
COPY --from=css-builder /app/wwwroot/css/site.css ./wwwroot/css/site.css
RUN dotnet publish "whoshippedit.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ==========================================
# STAGE 3: Final ASP.NET Core Runtime Image
# ==========================================
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose default port
EXPOSE 8080

# Bind dynamically to the port provided by Render (defaulting to 8080)
CMD ["sh", "-c", "dotnet whoshippedit.dll --urls http://0.0.0.0:${PORT:-8080}"]
