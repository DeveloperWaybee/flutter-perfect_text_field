git add -A && git commit -m "Release v2.1.0"
git tag 'v2.1.0'
git push --tags
git push origin
flutter pub publish
