#!/bin/bash
cd "c:\Users\goder\OneDrive\Desktop - Copy\CloudCampare-Ai-main"
export JAVA_HOME="C:\Program Files\Java\jdk-25.0.2"
export PATH="$JAVA_HOME\bin:$PATH"

echo "=== Java Version ==="
"$JAVA_HOME\bin\java.exe" -version

echo ""
echo "=== Compiling with Maven ==="
powershell -Command "
\$env:JAVA_HOME='C:\\Program Files\\Java\\jdk-25.0.2'
\$env:PATH=\"\$env:JAVA_HOME\\bin;\$env:PATH\"
.\mvnw.cmd clean compile -X
"
