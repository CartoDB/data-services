How to contribute
============
# Contributions

If you're interested in contributing to any of the different sections of the data-services geocoder, please submit a Pull Request with the following information:

* If you're adding new data, your PR must include:
  * The source of the data
  * The file itself or the URL from which it can be retrieved
  * The license of the dataset
  * The SQL file that includes the changes to be performed in the different scripts for generating the geocoding table with your new data
  * An updated README.md with the new data sources or any new step that might be necessary

* If you're editing any of the geocoding functions, your PR must include:
  * The updated SQL file which contains the function
  * An updated README.md with the new function information or any new step that might be necessary

## Documentation for changes

There may be different kind of changes in the dataset:

  * Refreshing current data in order to update it to the last source version or adding new sources

  * Fixing or editing any of the current functions

  All of them require:

  * An issue in the data-services repo to be opened to keep the record of the task
  * Any change must be tested in advance, by checking the results that we expect manually but also by running the automatic test suite that will take care of the most delicate data
  * Any change must be reviewed by at least one person involved in the whole geocoder process (as @iriberri). Please, ping somebody in your Pull Requests

  **Changes regarding data:**

  Remember to make a backup of the current data running in your production environment before you do any changes.

  Any edition of the data must be performed via SQL queries in order to be run over the existing data to patch it. An example of patch could be:
  ```sql
  -- Patch 0.0.1 data version -20160203

  DELETE FROM admin0_synonyms WHERE rank = 8 AND char_length(name_) < 4;
  ```
  
  Please, send your patch file in a PR for us to be able to set it up in the patch downloader and loader scripts of the project. Patchs should be associated to a data version and will be stored in: `geocoding/dumps/$VERSION/patches`
  
  This method will allow us to make sure that the data that we have in a production environment is totally reproducible just by running the setup scripts and the patches.

  **Changes regarding functions:**

  If you have a way to improve how a function works, please reproduce the environment (the involved tables) and test the query in your end.

  We need to make sure that by changing the function we are maintaining some basic priority rules which are currently being taken into account in the geocoding functions (i.e. geocoding "New York" should return "New York" in the NY state, USA, as it's the New York with more population in the World).


# Issues

If you have found any issue that you want to report, please [open a new issue in the repository](https://github.com/CartoDB/data-services/issues/new).

Thank you!
