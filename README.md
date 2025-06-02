# Firebase TestLab Action
Github action to upload test builds to firebase test-lab.
_Only tested with Android App Distributions_

## Example usage

```yml
name: Upload build to Firebase test-lab

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
      - name: Run Tests in Firebase Test Lab
        uses: Vizzn/firebase-testlab-action@v1.0
        with:
          arg-spec: 'testlab-configurations.yaml:android-pixel-5'
          results_dir: 'test-results'
        env:
          SERVICE_ACCOUNT: ${{ secrets.FIREBASE_TEST_LAB_SERVICE }}
          RESULTS_BUCKET: ${{ secrets.FIREBASE_RESULTS_BUCKET }}
```

