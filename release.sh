git add -A && git commit -m "Release v1.1.0+1"
git tag 'v1.1.0+1'
git push --tags
git push origin
flutter pub publish
