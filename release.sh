git add -A && git commit -m "Release v2.2.0+1"
git tag 'v2.2.0+1'
git push --tags
git push origin
flutter pub publish
