#!/usr/bin/env bash

NEXTCLOUD="nextcloud"

echo "=== Starting Nextcloud app installation ==="
echo "Using container: $NEXTCLOUD"
echo ""

apps=(
  "contacts"
  "deck"
  "notes"
  "passwords"
  "quota_warning"
  "tasks"
)

declare -A fail_reasons
success_list=()
fail_list=()

install_app() {
  local app="$1"
  echo "--- Installing app: $app ---"

  # Capture stderr AND stdout
  output=$(docker exec -it "$NEXTCLOUD" php /app/www/public/occ app:install "$app" 2>&1)
  status=$?

  if [ $status -eq 0 ]; then
    echo "--- Installed: $app ---"
    success_list+=("$app")
  else
    echo "!!! Failed installing: $app !!!"
    echo "$output"
    fail_list+=("$app")
    fail_reasons["$app"]="$output"
  fi

  echo ""
}

echo "Installing apps..."
for app in "${apps[@]}"; do
  install_app "$app"
done

echo "=== Restarting only Nextcloud container ==="
docker compose stop "$NEXTCLOUD"
docker compose up -d "$NEXTCLOUD"
echo ""

echo "===== Installation Summary ====="

echo "Successful apps:"
if [ ${#success_list[@]} -eq 0 ]; then
  echo "  (none)"
else
  for a in "${success_list[@]}"; do
    echo "  ✓ $a"
  done
fi

echo ""
echo "Failed apps:"
if [ ${#fail_list[@]} -eq 0 ]; then
  echo "  (none)"
else
  for a in "${fail_list[@]}"; do
    echo "  ✗ $a"
    echo "    Reason:"
    echo "      ${fail_reasons[$a]}" | sed 's/^/      /'
    echo ""
  done
fi

echo "================================="

