#!/bin/bash
set -e

echo "RUNNING COVERAGE SCRIPT"

# Ensure coverage folder exists
mkdir -p coverage

# 1️⃣ Run root tests if /test exists
if [ -d "test" ]; then
  echo "--- Running root tests ---"
  fvm flutter test --coverage
fi

# 2️⃣ Run tests in packages that have a test folder
for pkg in packages/*; do
  if [ -d "$pkg/test" ]; then
    echo "--- Running tests for package $pkg ---"
    (cd "$pkg" && fvm flutter test --coverage)
  fi
done

# 3️⃣ Merge all lcov.info files
echo "--- Merging coverage files ---"

# Start with root coverage if it exists
MERGE_CMD=""
if [ -f "coverage/lcov.info" ]; then
  MERGE_CMD="-a coverage/lcov.info"
fi

# Find all package coverage files
PKG_LCOV_FILES=$(find packages -type f -path "*/coverage/lcov.info")
for f in $PKG_LCOV_FILES; do
  MERGE_CMD="$MERGE_CMD -a $f"
done

echo "--- Fixing package paths ---"

for pkg in packages/*; do
  if [ -f "$pkg/coverage/lcov.info" ]; then
    echo "Fixing paths in $pkg"
    sed -i '' "s|SF:lib/|SF:$pkg/lib/|g" "$pkg/coverage/lcov.info"
  fi
done

# Merge into one file
lcov $MERGE_CMD -o coverage/lcov_merged.info

# 4️⃣ Filter out generated files
echo "--- Filtering generated files ---"
lcov --remove coverage/lcov_merged.info \
  '**/*.g.dart' '**/*.freezed.dart' '**/*.gen.dart' \
  '**/generated_plugin_registrant.dart' \
  --ignore-errors unused \
  -o coverage/lcov_filtered.info

# 5️⃣ Generate HTML report
echo "--- Generating HTML report ---"
genhtml coverage/lcov_filtered.info -o coverage/html --ignore-errors source

echo "✅ Coverage report ready: coverage/html/index.html"