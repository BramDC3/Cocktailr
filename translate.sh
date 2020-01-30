#!/usr/bin/env sh

set -e # Exit on first failed command

# Variables
LOCO_API_KEY=$COCKTAILR_LOCO_KEY
APP_LOCALIZATIONS_PATH="lib/src/services/app_localizations.dart"
OUTPUT_DIR="lib/l10n"

# Get packages
flutter packages get

# Generate ARB files
mkdir l10n-input
flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-input $APP_LOCALIZATIONS_PATH

# Import translations into Loco
curl -f -s --data-binary "@l10n-input/intl_messages.arb" "https://localise.biz/api/import/arb?async=true&index=id&locale=en&key=$LOCO_API_KEY"

# Export translations from Loco
curl -s -o "translated.zip" "https://localise.biz/api/export/archive/arb.zip?key=$LOCO_API_KEY"
unzip -qq "translated.zip" -d "l10n-translated"

# Generate Dart files with translations
flutter pub pub run intl_translation:generate_from_arb --output-dir=$OUTPUT_DIR --no-use-deferred-loading $APP_LOCALIZATIONS_PATH l10n-translated/*/l10n/intl_messages_*.arb

# Cleanup
rm translated.zip
rm -rf l10n-translated
rm -rf l10n-input
