git add -A && git commit -m "Release v1.1.0+2"
git tag 'v1.1.0+2'
git push --tags
git push origin
flutter pub publish
