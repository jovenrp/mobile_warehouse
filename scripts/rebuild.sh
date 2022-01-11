
echo 'Running rebuild.sh'

fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm dart plugins/i18n_generator/lib/main.dart --output lib/generated/i18n_lookup.generated.dart

fvm flutter format lib