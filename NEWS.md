<!-- NEWS.md is maintained by https://fledge.cynkra.com, contributors should not edit this file -->

# subreport 0.0.0.9019

- Internal changes only.


# subreport 0.0.0.9018

- Add functionality in `sbr_table()` to control significant figures for numeric columns in data.frame prior to converting to markdown table for report. 
- New arguments`sigfig` and `sigfig_override` set default significant figures and significant figures for specific table, respectively.

# subreport 0.0.0.9017

- Fixed Windows, versus Mac and Linux, path format for `sbr_knit_results()`.

# subreport 0.0.0.9016

- Add extra line break to model blocks to ensure correct PDF wrapping behaviour in poisreport.


# subreport 0.0.0.9015

- Added pre_num argument to `sbr_figures()`.
- `sbr_number()` and `sbr_string()` now return NULL if number or string doesn't exist.
- Replaced err with chk dependency.
- Removed sbr_database().


# subreport 0.0.0.9014

- Added a `NEWS.md` file to track changes to the package.
