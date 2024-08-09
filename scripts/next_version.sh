#!/bin/bash

# Get the current date components
current_year=$(date +'%Y')
current_month=$(date +'%m')

# Determine the current quarter
case $current_month in
  01|02|03) current_quarter="Q1" ;;
  04|05|06) current_quarter="Q2" ;;
  07|08|09) current_quarter="Q3" ;;
  10|11|12) current_quarter="Q4" ;;
esac

# Get the latest project version
project_version=$1

# Extract the project verion year, quarter and patch level
project_version_year=$(echo "$project_version" | sed 's|.*/v||' | cut -d'.' -f1)
project_version_quarter=$(echo "$project_version" | cut -d'.' -f2 | cut -d'-' -f1)
project_version_patch_level=$(echo "$project_version" | sed -E 's/^.*-([0-9]+)$/\1/')

# Determine the next project version
# Compare the project verions year and quarter with the current year and quarter
if [[ "$project_version_year" == "$current_year" && "$project_version_quarter" == "$current_quarter" ]]; then
  # We are still in the same year and quarter
  next_patch_level=$((project_version_patch_level + 1))
else
  # We are in either a different year or quarter
  next_patch_level=1

fi

next_project_version="cli/${current_year}.${current_quarter}-${next_patch_level}"
echo "$next_project_version"
