% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/table_spec.r
\name{stub}
\alias{stub}
\title{Defines a report stub}
\usage{
stub(
  x,
  vars,
  label = "",
  label_align = NULL,
  align = "left",
  width = NULL,
  standard_eval = FALSE,
  style = NULL
)
}
\arguments{
\item{x}{The table spec.}

\item{vars}{A vector of quoted or unquoted variable names from 
which to create the stub. If you want to pass an R variable of names,
escape the values with double curly braces, i.e. \code{vars = {{myvar}}}.
The curly brace escape is useful when writing functions that construct
reports dynamically.}

\item{label}{The label for the report stub.  The default label is an empty
string.}

\item{label_align}{The alignment for the stub column label.
Valid values are 'left', 'right', 'center', and 'centre'.  Default follows
the \code{align} parameter.}

\item{align}{How to align the stub column.  Valid values are 'left', 
'right', 'center', and 'centre'.  Default is 'left'.}

\item{width}{The width of the stub, in report units of measure.}

\item{standard_eval}{A TRUE or FALSE value that indicates whether to
use standard or non-standard evaluation of the \code{vars}, \code{from},
and \code{to} parameters.  Set \code{standard_eval} to TRUE if you want
to pass the column names as variables. Default is FALSE, meaning it
will use non-standard (unquoted) evaluation.}

\item{style}{A \code{\link{cell_style}} object that contains the style
specifications for the stub.}
}
\value{
The modified table spec.
}
\description{
Combine columns into a nested report stub.  The report stub
is a common feature of statistical reports.  The stub is created with
the \code{stub} function, and frequently appears in combination with the 
\code{label_row} and \code{indent} parameters from the 
\code{\link{define}} function.  These elements work together to define
the appearance of the stub.
}
\details{
The table stub is a nested set of labels that identify rows 
on the table. The stub is created by combining two or more columns into 
a single stub column.  The relationship between the columns is typically 
visualized as a hierarchy, with lower level concepts indented under 
higher level concepts.  

A typical stub is created with the following steps:
\itemize{
  \item Prepare the data. 
  \item Create the table object.
  \item Define the stub on the table using the \code{stub} function, 
  and identify the variables to be combined.
  \item Identify higher level concepts with the \code{label_row} parameter
  on the \code{\link{define}} function. 
  \item Identify lower level concepts using the \code{indent} parameter 
  on the \code{\link{define}} function.
}

The stub will be automatically added as an identity variable on the report, 
and will always appear as the leftmost column.  There can only be one stub 
defined on a report.

If you wish to create multiple levels of nested labels, use
an NA value to prevent lower level labels from overwriting
higher level labels. 

For example, the following data:
\preformatted{
continent          country   state_province    
"North America"    NA        NA   
"North America"    "Canada"  NA   
"North America"    "Canada"  "Ontario"   
"North America"    "USA"     NA   
"North America"    "USA"     "New York"   
"South America"    NA        NA   
"South America"    "Brazil"  NA   
"South America"    "Brazil"  "Amazonas"   
"South America"    "Brazil"  "Bahia"   
}
Will produce the following stub:   
\preformatted{
North America   
  Canada   
    Ontario   
  USA   
    New York   
South America  
  Brazil 
    Amazonas   
    Bahia   
}
With the following code:
\preformatted{
tbl <- create_table(dat) \%>\% 
  stub(c(continent, country, state_province)) \%>\% 
  define(country, indent = .25) \%>\% 
  define(state_province, indent = .5)
}
}
\examples{
library(reporter)
library(magrittr)

# Create temporary path
tmp <- file.path(tempdir(), "stub.txt")

# Read in prepared data
df <- read.table(header = TRUE, text = '
      var      label        A             B          
      "ampg"   "N"          "19"          "13"         
      "ampg"   "Mean"       "18.8 (6.5)"  "22.0 (4.9)" 
      "ampg"   "Median"     "16.4"        "21.4"       
      "ampg"   "Q1 - Q3"    "15.1 - 21.2" "19.2 - 22.8"
      "ampg"   "Range"      "10.4 - 33.9" "14.7 - 32.4"
      "cyl"    "8 Cylinder" "10 ( 52.6\%)" "4 ( 30.8\%)" 
      "cyl"    "6 Cylinder" "4 ( 21.1\%)"  "3 ( 23.1\%)" 
      "cyl"    "4 Cylinder" "5 ( 26.3\%)"  "6 ( 46.2\%)"')

# Create table
tbl <- create_table(df, first_row_blank = TRUE) \%>\% 
  stub(c(var, label)) \%>\% 
  define(var, blank_after = TRUE, label_row = TRUE, 
         format = c(ampg = "Miles Per Gallon", cyl = "Cylinders")) \%>\% 
  define(label, indent = .25) \%>\% 
  define(A, label = "Group A", align = "center", n = 19) \%>\% 
  define(B, label = "Group B", align = "center", n = 13)


# Create report and add content
rpt <- create_report(tmp, orientation = "portrait") \%>\% 
  page_header(left = "Client: Motor Trend", right = "Study: Cars") \%>\% 
  titles("Table 1.0", "MTCARS Summary Table") \%>\% 
  add_content(tbl) \%>\% 
  footnotes("* Motor Trend, 1974") \%>\%
  page_footer(left = Sys.time(), 
              center = "Confidential", 
              right = "Page [pg] of [tpg]")

# Write out report
write_report(rpt)

# View report in console
writeLines(readLines(tmp, encoding = "UTF-8"))

# Client: Motor Trend                                                Study: Cars
#                                   Table 1.0
#                              MTCARS Summary Table
# 
#                                     Group A      Group B
#                                      (N=19)       (N=13)
#                 -------------------------------------------
# 
#                 Miles Per Gallon
#                    N                   19           13
#                    Mean            18.8 (6.5)   22.0 (4.9)
#                    Median             16.4         21.4
#                    Q1 - Q3        15.1 - 21.2  19.2 - 22.8
#                    Range          10.4 - 33.9  14.7 - 32.4
#
#                 Cylinders
#                    8 Cylinder     10 ( 52.6\%)   4 ( 30.8\%)
#                    6 Cylinder      4 ( 21.1\%)   3 ( 23.1\%)
#                    4 Cylinder      5 ( 26.3\%)   6 ( 46.2\%)
# 
# ...
# 
# 
# * Motor Trend, 1974
# 
# 2020-08-30 03:50:02              Confidential                      Page 1 of 1
#
}
\seealso{
Other table: 
\code{\link{column_defaults}()},
\code{\link{create_table}()},
\code{\link{define}()},
\code{\link{print.table_spec}()},
\code{\link{spanning_header}()}
}
\concept{table}
