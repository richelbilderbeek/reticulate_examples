# Example 4
#
# Installs scipy
# Installs using conda_install
# Uses default Python version

# We use only one point of contact
ormr_folder_name <- tempfile(pattern = "ormr_")
ormr_folder_name

# Initially, nothing is installed, this must be verified
testthat::expect_false(
  basename(ormr_folder_name) %in% reticulate::conda_list()$name
)

# Create and activate default Python version
python_path <- reticulate::conda_create(
  envname = ormr_folder_name
)

testthat::expect_true(file.exists(python_path))
reticulate::use_condaenv(condaenv = ormr_folder_name)
reticulate::use_python(python = python_path, required = TRUE)

# Our conda env is in the list
testthat::expect_true(
  basename(ormr_folder_name) %in% reticulate::conda_list()$name
)

# Get a list of the installed Python packages
reticulate:::conda_list_packages(envname = ormr_folder_name)

# scipy (or any other absent package) will not be in that list yet:
# taken from https://anaconda.org/anaconda/scipy
package_name <- "scipy"
testthat::expect_false(
  package_name %in% reticulate:::conda_list_packages(
    envname = ormr_folder_name
  )$package
)

# Install the Python package
reticulate::conda_install(
  packages = package_name,
  envname = ormr_folder_name
)

testthat::expect_true(
  package_name %in% reticulate:::conda_list_packages(
    envname = ormr_folder_name
  )$package
)

