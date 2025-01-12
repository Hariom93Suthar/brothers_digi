# Use CirrusLabs Flutter base image
FROM ghcr.io/cirruslabs/flutter:3.27.1

# Install required tools and dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    android-sdk \
    android-sdk-build-tools \
    git \
    curl \
    wget \
    unzip \
    && apt-get clean

# Create a new user
RUN useradd -m flutteruser

# Set working directory
WORKDIR /app

# Set permissions for Flutter SDK
RUN chown -R flutteruser:flutteruser /sdks/flutter

# Switch to flutteruser
USER flutteruser

# Configure Flutter and check doctor
RUN flutter config --no-analytics && \
    flutter doctor

# Copy pubspec files
COPY pubspec.yaml pubspec.lock ./

# Set permissions for flutteruser after copying pubspec files
USER root
RUN chown -R flutteruser:flutteruser /app
USER flutteruser

# Install dependencies
RUN flutter pub get

# Copy all source files
COPY . .

# Build the Flutter app
#RUN flutter build apk --release

# Expose port (if required)
EXPOSE 8080

# Define default command
CMD ["bash"]
