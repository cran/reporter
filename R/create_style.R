
# Style class -------------------------------------------------------------

#' @title 
#' Creates a style object
#' @description 
#' This function will create a style object to control background colors and 
#' font settings on your report.  The style object can be applied to a 
#' report using the \code{\link{add_style}} function. Currently, styles may only
#' be applied to HTML reports.
#' @details
#' The style object contains style settings for a report. The style object 
#' allows you to control background colors and font specifications such as 
#' font size, font color, and font bold.  The style object can be created
#' once and reused on many reports.  See the \code{\link{add_style}} function
#' to learn how to add the style object to a report.  
#' 
#' Note that styles will be applied uniformly to the entire report.  Also note
#' that at present, styles can be used only on HTML output types. Future versions
#' of the \strong{reporter} package will provide style support for other 
#' output types.
#' 
#' On the style object, colors for background and fonts may be passed as 
#' an RGB hex code or a color name. For example, the color red may be passed as
#' the hex code "#FF0000" or as the color name "Red". Color names must conform
#' to HTML/CSS standards.  These color names can be easily discovered on 
#' the internet.  A sample of common color names is presented below.
#' 
#' @section Color Names:
#' Many of the parameters on the style object accept a color name or code.
#' The values accepted for these parameters follow standard HTML/CSS style
#' color values.  Below is a sample of common color names
#' that can be used to specify colors with the \code{create_style} function.
#' These color names should be passed as a quoted string:
#' \itemize{
#'   \item \strong{Primary and Secondary Colors:} Black, White, Red, Yellow, 
#'   Blue, Green, Orange, Purple and Brown.
#'   \item \strong{Common Shades:} Beige, Crimson, Gold, Indigo, Ivory, Lavender, 
#'   Maroon, Navy, Olive, Pink, 
#'   Plum, RoyalBlue, Silver, Teal, Turquoise, Violet
#'   \item \strong{Shades of White:} AntiqueWhite, Azure, GhostWhite, 
#'   SeaShell, Snow, WhiteSmoke
#'   \item \strong{Shades of Grey:} Grey, Gray, DarkGray, DarkGrey, DimGray, DimGrey, 
#'   LightGray, LightGrey, SlateGray, SlateGrey
#'   \item \strong{Shades of Blue:} AliceBlue, CadetBlue, CornflowerBlue, 
#'   DodgerBlue, PowderBlue, LightBlue, MidnightBlue, SkyBlue, SlateBlue, SteelBlue
#'   \item \strong{Earth Colors:} Beige, Bisque, BurlyWood, ForestGreen, Khaki,
#'    Linen, SandyBrown, SaddleBrown, Salmon, SeaGreen, Sienna, Tan, Thistle, Wheat
#'   \item \strong{Bright Colors:} Aqua, Aquamarine, BlueViolet, Cyan, Fuchia, 
#'   HotPink, Lime, Magenta, OrangeRed, SpringGreen
#' }
#' @param font_name The name of the font to use on the report.  Valid values
#' are "Courier", "Arial", or "Times".  The default is "Courier".
#' @param font_size The default font size to use for the report.  This font
#' size will be used for all text, unless overridden by another font size 
#' parameter.
#' @param text_color The default color to use for all text in the report.  This
#' parameter will apply to the entire report, unless overridden by other
#' font color settings.
#' @param background_color The color to use for the background of the report.
#' This color will appear everywhere on the document unless overridden 
#' by another color specification.  
#' @param title_font_size The font size to use for the title font in points.
#' @param title_font_bold Whether to bold the title or not.  Valid values 
#' are TRUE or FALSE. By default, the title will not be bold.
#' @param title_font_color The color to use for the title font.
#' @param title_background The background color for the title block.
#' @param footnote_font_bold Whether to bold the footnote or not.  Valid values 
#' are TRUE or FALSE. By default, the footnote will not be bold.
#' @param footnote_font_color The font color to use for footnotes.
#' @param footnote_background The color to be used for the background of 
#' footnotes.
#' @param border_color The color to use for all borders in the report.  
#' By default, the border will be black.
#' @param table_header_background The background color to use in the table header.
#' This color may be different than the background color used in the table
#' body.
#' @param table_header_font_bold Whether to bold the header labels or not.  
#' Valid values are TRUE and FALSE. By default, the header will not be bold.
#' @param table_header_font_color The font color to use on the table header.
#' @param table_body_background The background color to use in the body of any 
#' table in the report. 
#' @param table_body_stripe The background color to use for every other row
#' in a table.  The stripe color is used in conjunction with the body background
#' color to perform table striping.  The stripe color will start on the second row.
#' @param table_body_font_color The font color to use for the body of any 
#' table in the report.  
#' @param table_stub_background The background color to use for the stub column,
#' if one exists on the table. 
#' @param table_stub_font_color The font color to be used for the stub column,
#' if one exists on the table.
#' @param table_stub_font_bold Whether or not to bold the stub column.  Valid
#' values are TRUE and FALSE.
#' @param table_label_row_bold Whether or not to bold the label row on a stub
#' column.  This parameter is so you can bold the label row, but not the 
#' values in the stub column.  Valid values are TRUE and FALSE.
#' @family styles
#' @examples 
#' library(reporter)
#' library(magrittr)
#' 
#' # Prepare data
#' dat <- data.frame(stub = rownames(mtcars), mtcars)
#' dat <- dat[1:15, ]
#' 
#' # Create temp file path
#' tmp <- file.path(tempdir(), "HairAndEyes2.html")
#' 
#' # Define custom style
#' sty <- create_style(font_name = "Arial",
#'                     font_size = 10,
#'                     background_color = "WhiteSmoke",
#'                     border_color = "Grey",
#'                     title_font_size = 12,
#'                     title_font_bold = TRUE,
#'                     title_font_color = "SteelBlue",
#'                     table_header_background = "Tan",
#'                     table_header_font_bold = TRUE,
#'                     table_header_font_color = "White",
#'                     table_body_background = "White",
#'                     table_body_stripe = "Wheat", 
#'                     table_stub_background = "Tan",
#'                     table_stub_font_color = "White")
#' 
#' # Create table object
#' tbl <- create_table(dat, borders = "all") %>% 
#' titles("MTCARS Dataset With Style") %>% 
#' column_defaults(width = .5) %>% 
#' define(stub, label = "Car Make and Model", width = 1.5)
#' 
#' # Create report and add style spec
#' rpt <- create_report(tmp, output_type = "HTML") %>% 
#'        add_content(tbl) %>% 
#'        add_style(style = sty)
#'
#' # Write out the report        
#' write_report(rpt)
#' 
#' # Uncomment to View report
#' # file.show(tmp)
#' @export
create_style <- function(font_name = NULL,
                         font_size = NULL,
                         text_color = NULL,
                         background_color = NULL,
                         title_font_size = NULL,
                         title_font_bold = NULL,
                         title_font_color = NULL,
                         title_background = NULL,
                         footnote_font_bold = NULL,
                         footnote_font_color = NULL,
                         footnote_background = NULL,
                         border_color = NULL,
                         table_header_background = NULL,
                         table_header_font_bold = NULL,
                         table_header_font_color = NULL,
                         table_body_background = NULL,
                         table_body_stripe = NULL,
                         table_body_font_color = NULL,
                         table_stub_background = NULL,
                         table_stub_font_color = NULL,
                         table_stub_font_bold = NULL,
                         table_label_row_bold = NULL) {


  ret <- structure(list(), class = c("style_spec", "list"))
  
  ret$font_name <- font_name
  ret$font_size <- font_size
  ret$text_color <- text_color
  ret$background_color <- background_color
  ret$title_font_size <- title_font_size
  ret$title_font_bold <- title_font_bold
  ret$title_font_color <- title_font_color
  ret$title_background <- title_background
  ret$footnote_font_bold <- footnote_font_bold
  ret$footnote_font_color <- footnote_font_color
  ret$footnote_background <- footnote_background
  ret$border_color <- border_color
  ret$table_header_background <- table_header_background
  ret$table_header_font_bold <- table_header_font_bold
  ret$table_header_font_color <- table_header_font_color
  ret$table_body_background <- table_body_background
  ret$table_body_stripe <- table_body_stripe
  ret$table_stub_background <- table_stub_background
  ret$table_stub_font_color <- table_stub_font_color
  ret$table_stub_font_bold <- table_stub_font_bold
  ret$table_body_font_color <- table_body_font_color
  ret$table_label_row_bold <- table_label_row_bold
  
  
  return(ret)

}

#' @title 
#' Add a style object to a report.
#' @description 
#' This function will add a style object to a report specification.  The 
#' style may be added either by passing a style object to the \code{style} 
#' parameter, or by passing a theme name to the \code{theme} parameter.
#' @details
#' The \code{add_style()} function allows you to add styling to HTML reports.
#' This functionality will apply to additional output types in future
#' versons of the \strong{reporter} package.
#' 
#' Styling can be added by passing a named theme to the \code{theme} parameter,
#' or by creating a style object using the \code{\link{create_style}} function
#' and passing that object to the \code{style} parameter.  You may also export 
#' a theme as a style object using the \code{\link{get_theme}} function,
#' modify it, and pass that to the \code{style} parameter.
#' 
#' @section Style Specifications:
#' The style specification is created using the \code{\link{create_style}} function,
#' and provides the most styling flexibility.  The style object allows you
#' to control background colors, font colors, border colors, and more.  Colors
#' can be specified using an RGB hex code, or an HTML/CSS-compliant color name.
#' See the \code{\link{create_style}} documentation for additional information.
#' 
#' @section Themes:
#' There are currently seven themes available: "MidnightBlue", "SteelBlue", 
#' "DarkRed", "SeaGreen", "SlateGrey", "Plain", and "SASDefault". 
#' All themes use Arial 10pt font. These themes are intended to provide a 
#' basic set of examples on how to create styles. Themes can be used by 
#' passing the theme name to the theme parameter on the \code{add_style()}
#' function. The theme will assign a variety of style settings according 
#' to the specifics of the theme.  For example, the "MidnightBlue" theme
#' sets the title font and header background colors to "MidnightBlue" and sets
#' the border color to "Grey".
#' 
#' To view theme style settings, you can use \code{\link{get_theme}} function. 
#' This function will return the theme as a style object.  See
#' the \code{\link{get_theme}} documentation for further details.
#' @param rpt The report specification to add a style to.
#' @param style A style object which contains style settings to add to the 
#' report. This parameter is optional.  Default is NULL.  
#' @param theme A theme name to use for this report. Valid values are
#' "MidnightBlue", "SteelBlue", "DarkRed", "SeaGreen", "SlateGrey", "Plain", 
#' and "SASDefault".  Default is NULL.
#' @family styles
#' @examples 
#' library(reporter)
#' library(magrittr)
#' 
#' # Prepare data
#' dat <- as.data.frame(HairEyeColor)
#' dat <- dat[dat$Freq >= 10, ]
#' 
#' ## Example 1: Use Pre-defined Theme ##
#' 
#' # Create temp file path
#' tmp1 <- file.path(tempdir(), "HairAndEyes1.html")
#' 
#' # Create table object
#' tbl <- create_table(dat, borders = "outside") %>% 
#' titles("Hair and Eye Colors with Theme") %>% 
#' column_defaults(width = .6)
#' 
#' # Create report and add theme
#' rpt <- create_report(tmp1, output_type = "HTML") %>% 
#'        add_content(tbl) %>% 
#'        add_style(theme = "SteelBlue")
#'
#' # Write out the report        
#' write_report(rpt)
#' 
#' # Uncomment to View report
#' # file.show(tmp1)
#' 
#' #' ## Example 2: Create Custom Style ##
#' 
#' # Create temp file path
#' tmp2 <- file.path(tempdir(), "HairAndEyes2.html")
#' 
#' # Define custom style
#' sty <- create_style(font_name = "Times",
#'                     font_size = 10,
#'                     title_font_size = 12,
#'                     title_font_bold = TRUE,
#'                     title_font_color = "Blue",
#'                     table_header_background = "Blue",
#'                     table_header_font_bold = TRUE,
#'                     table_header_font_color = "White",
#'                     table_body_background = "White",
#'                     table_body_stripe = "Red")
#' 
#' # Create table object
#' tbl <- create_table(dat, borders = "outside") %>% 
#' titles("Hair and Eye Colors with Style") %>% 
#' column_defaults(width = .6)
#' 
#' # Create report and add style spec
#' rpt <- create_report(tmp2, output_type = "HTML") %>% 
#'        add_content(tbl) %>% 
#'        add_style(style = sty)
#'
#' # Write out the report        
#' write_report(rpt)
#' 
#' # Uncomment to View report
#' # file.show(tmp2)
#' @export
add_style <- function(rpt, style = NULL, theme = NULL) {
  
  if (is.null(rpt)) {
    stop("Report object cannot be NULL.") 
    
  }
  
  if (is.null(style) & is.null(theme)) {
    stop("Style object and theme cannot both be NULL.") 
    
  }
  
  if (!any(class(rpt) %in% c("report_spec"))) {
    
    stop("First parameter to add_style() must be a report spec.") 
  }
  
  if (!is.null(style)) {
    if (!any(class(style) %in% c("style_spec"))) {
      
     stop("Style parameter to add_style() must be a style spec.") 
    }
  }
  
  if (!is.null(theme)) {
    if (!any(class(theme) %in% c("character"))) {
      
      stop("Theme parameter to add_style() must be a valid theme name.") 
    }
  }
  
  # Get theme if requested
  if (!is.null(theme)) {
    
    style <- get_theme(theme)
  } 
  
  if (!is.null(style)) {
    
    rpt$style <- style
    
    # Set font name and size if requested
    if (!is.null(style$font_name))
      rpt$font <- style$font_name
    
    if (!is.null(style$font_size))
      rpt$font_size <- style$font_size
  }
  
  
    
  return(rpt)
  
}

#' @title 
#' Get a theme 
#' @description 
#' This function will return a style object for a specified theme.
#' There are currently seven themes available.  The returned object 
#' may be modifed and applied to a report using \code{\link{add_style}}.
#' @param theme A string that contains the desired theme name to return.
#' Valid values are "MidnightBlue", "SteelBlue", "DarkRed", "SeaGreen", 
#' "SlateGrey", "Plain", and "SASDefault". 
#' @family styles
#' @examples 
#' library(reporter)
#' library(magrittr)
#' 
#' # Get theme
#' tm <- get_theme("SteelBlue")
#' 
#' # View theme settings
#' print(tm)
#' ## A style specification: 
#' #- font_name: 'Arial'
#' #- font_size: 10
#' #- text_color: 'DimGrey'
#' #- title_font_size: 11
#' #- title_font_bold: TRUE
#' #- title_font_color: 'SteelBlue'
#' #- border_color: 'Grey'
#' #- table_header_background: 'SteelBlue'
#' #- table_header_font_bold: TRUE
#' #- table_header_font_color: 'LightGrey'
#' #- table_body_background: 'White'
#' #- table_body_stripe: 'WhiteSmoke'
#' #- table_stub_background: 'SteelBlue'
#' #- table_stub_font_color: 'LightGrey'
#' #- table_stub_font_bold: TRUE
#' 
#' # Modify theme
#' tm$font_size <- 12
#' tm$title_font_size <- 13
#' 
#' # Create temp file path
#' tmp <- file.path(tempdir(), "HairAndEyes.html")
#' 
#' # Get data
#' dat <- as.data.frame(HairEyeColor)
#' 
#' # Create table object
#' tbl <- create_table(dat[dat$Freq >= 10, ], 
#' borders = "outside") %>% 
#' titles("Hair and Eye Colors")
#' 
#' # Use modified theme
#' rpt <- create_report(tmp, output_type = "HTML") %>% 
#'        add_content(tbl) %>% 
#'        add_style(tm)
#'
#' # Write out the report        
#' write_report(rpt)
#' 
#' # Uncomment to View report
#' # file.show(tmp)
#' 
#' @export
get_theme <- function(theme) {
  
  ret <- NULL
  
  if (tolower(theme) == "sasdefault") {
    
    ret <- create_style(font_name = "Arial",
                        font_size = 10,
                        text_color = "DimGrey",
                        background_color = "#FAFBFE",
                        title_font_color = "MidnightBlue",
                        title_font_bold = TRUE,
                        title_font_size = 11,
                        border_color = "Grey",
                        table_header_background = "#EDF2F9",
                        table_header_font_bold = TRUE,
                        table_header_font_color = "MidnightBlue",
                        table_body_background = "White",
                        table_stub_background = "#EDF2F9",
                        table_stub_font_bold = TRUE,
                        table_stub_font_color = "MidnightBlue",
                        footnote_background = "#EDF2F9",
                        footnote_font_color = "MidnightBlue",
                        footnote_font_bold = TRUE)
    
  } else if (tolower(theme) == "midnightblue") {
      
      ret <- create_style(font_name = "Arial",
                          font_size = 10,
                          text_color = "DimGrey",
                          background_color = NULL,
                          title_font_color = "MidnightBlue",
                          title_font_bold = TRUE,
                          title_font_size = 11,
                          border_color = "Grey",
                          table_header_background = "MidnightBlue",
                          table_header_font_bold = TRUE,
                          table_header_font_color = "LightGrey",
                          table_body_background = "White",
                          table_stub_background = "MidnightBlue",
                          table_stub_font_bold = TRUE,
                          table_stub_font_color = "LightGrey",
                          table_body_stripe = "WhiteSmoke")
      
   } else if (tolower(theme) == "darkred") {
      
      ret <- create_style(font_name = "Arial",
                          font_size = 10,
                          text_color = "DimGrey",
                          background_color = NULL,
                          title_font_color = "DarkRed",
                          title_font_bold = TRUE,
                          title_font_size = 11,
                          border_color = "Grey",
                          table_header_background = "DarkRed",
                          table_header_font_bold = TRUE,
                          table_header_font_color = "LightGrey",
                          table_body_background = "White",
                          table_stub_background = "DarkRed",
                          table_stub_font_bold = TRUE,
                          table_stub_font_color = "LightGrey",
                          table_body_stripe = "WhiteSmoke")
      
   } else if (tolower(theme) == "seagreen") {
     
     ret <- create_style(font_name = "Arial",
                         font_size = 10,
                         text_color = "DimGrey",
                         background_color = NULL,
                         title_font_color = "SeaGreen",
                         title_font_bold = TRUE,
                         title_font_size = 11,
                         border_color = "Grey",
                         table_header_background = "SeaGreen",
                         table_header_font_bold = TRUE,
                         table_header_font_color = "LightGrey",
                         table_body_background = "White",
                         table_stub_background = "SeaGreen",
                         table_stub_font_bold = TRUE,
                         table_stub_font_color = "LightGrey",
                         table_body_stripe = "WhiteSmoke")
     
   } else if (tolower(theme) == "steelblue") {
     
     ret <- create_style(font_name = "Arial",
                         font_size = 10,
                         text_color = "DimGrey",
                         background_color = NULL,
                         title_font_color = "SteelBlue",
                         title_font_bold = TRUE,
                         title_font_size = 11,
                         border_color = "Grey",
                         table_header_background = "SteelBlue",
                         table_header_font_bold = TRUE,
                         table_header_font_color = "LightGrey",
                         table_body_background = "White",
                         table_stub_background = "SteelBlue",
                         table_stub_font_bold = TRUE,
                         table_stub_font_color = "LightGrey",
                         table_body_stripe = "WhiteSmoke")
     
   } else if (tolower(theme) == "slategrey") {
     
     ret <- create_style(font_name = "Arial",
                         font_size = 10,
                         text_color = "DimGrey",
                         background_color = NULL,
                         title_font_color = "SlateGrey",
                         title_font_bold = TRUE,
                         title_font_size = 11,
                         border_color = "Grey",
                         table_header_background = "SlateGrey",
                         table_header_font_bold = TRUE,
                         table_header_font_color = "LightGrey",
                         table_body_background = "White",
                         table_stub_background = "SlateGrey",
                         table_stub_font_bold = TRUE,
                         table_stub_font_color = "LightGrey",
                         table_body_stripe = "WhiteSmoke")
     
   } else if (tolower(theme) == "plain") {
     
     ret <- create_style(font_name = "Arial",
                         font_size = 10,
                         title_font_bold = TRUE,
                         title_font_size = 11,
                         border_color = "Grey",
                         table_header_font_bold = TRUE,
                         table_label_row_bold = TRUE)
  } else {
    
   stop(paste0("Theme name '", theme, "' is not available."))
    
  }
  
  return(ret)
  
}


#' @title 
#' Prints a style specification
#' @description 
#' This function will print a style object to the console.  The print function
#' will display each style setting that has been assigned, and the value
#' which is assigned.
#' @param x A style object to print.
#' @param ... Any follow-on parameters to pass to print().
#' @param verbose If verbose is TRUE, the function will print the style
#' object as a list. Otherwise, the object will print using the custom
#' print function.  The custom print is more compact than the verbose style 
#' print. Default is FALSE.
#' @family styles
#' @import crayon
#' @examples 
#' library(reporter)
#' 
#' # Get theme
#' tm <- get_theme("SteelBlue")
#' 
#' # View theme settings
#' print(tm)
#' ## A style specification: 
#' #- font_name: 'Arial'
#' #- font_size: 10
#' #- text_color: 'DimGrey'
#' #- title_font_size: 11
#' #- title_font_bold: TRUE
#' #- title_font_color: 'SteelBlue'
#' #- border_color: 'Grey'
#' #- table_header_background: 'SteelBlue'
#' #- table_header_font_bold: TRUE
#' #- table_header_font_color: 'LightGrey'
#' #- table_body_background: 'White'
#' #- table_body_stripe: 'WhiteSmoke'
#' #- table_stub_background: 'SteelBlue'
#' #- table_stub_font_color: 'LightGrey'
#' #- table_stub_font_bold: TRUE
#' @export
print.style_spec <- function(x, ..., verbose = FALSE) {
  
  if (verbose == TRUE) {
    
    
    print(as.list(unclass(x)))
    
    
    
  } else {
    
    grey60 <- make_style(grey60 = "#999999")
    
    # Print header
    cat(grey60("# A style specification: \n"))
    
    # Print values for each style parameter
    for (nm in names(x)) {
      
      if (any(class(x[[nm]]) %in% "character")) {
      
        cat(paste0("- ", nm, ": '", x[[nm]], "'\n"))
        
      } else {
        cat(paste0("- ", nm, ": ", x[[nm]], "\n"))
        
      } 

    }
    
  }
  
  invisible(x)
  
}




# A function to determine whether a style exists.
# Returns a TRUE or FALSE.
#' @noRd
has_style <- function(rs, style_name) {
 
  ret <- FALSE
  
  if (!is.null(rs$style)) {
    if (!is.null(rs$style[[style_name]])) {
      
      ret <- TRUE 
    }
  }
  
  return(ret)
  
}

# A function to get a style value if it exists.
# Returns the value or an empty string if it does not exist.
#' @noRd
get_style <- function(rs, style_name) {
  
  ret <- ""
  
  if (!is.null(rs$style)) {
    if (!is.null(rs$style[[style_name]])) {
      
      ret <- rs$style[[style_name]]
    }
  }
  
  return(ret)
}

# A function to convert a style setting to the appropriate css.
# Returns an empty string if the style setting is not found.
#' @noRd
get_style_html <- function(rs, style_name, default = NULL) {
  
  ret <- ""
  
  val <- ""
  
  if (!is.null(default))
    val <- default
  if (has_style(rs, style_name))
    val <- get_style(rs, style_name)
  

  if (val != "") {
    
    if (style_name == "text_color")
      ret <- paste0("color: ", val, ";")
    
    if (style_name == "title_font_color")
      ret <- paste0("color: ", val, ";")
    
    if (style_name == "title_background")
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "title_font_size")
      ret <- paste0("font-size: ", val, "pt;")
    
    if (style_name == "title_font_bold") {
      if (val == TRUE)
        ret <- paste0("font-weight: bold;")
      else 
        ret <- paste0("font-weight: normal;")
      
    }
    
    if (style_name == "footnote_font_color")
      ret <- paste0("color: ", val, ";")
    
    if (style_name == "footnote_background")
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "footnote_font_bold") {
      if (val == TRUE)
        ret <- paste0("font-weight: bold;")
      else 
        ret <- paste0("font-weight: normal;")
      
    }
    
    if (style_name == "background_color")
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "table_body_font_color")
      ret <- paste0("color: ", val, ";")
    
    if (style_name == "table_body_background")
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "table_body_stripe")
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "table_header_background") 
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "table_header_font_bold") {
      if (val == TRUE)
        ret <- paste0("font-weight: bold;")
      else 
        ret <- paste0("font-weight: normal;")
    }
    
    if (style_name == "table_header_font_color")
      ret <- paste0("color: ", val, ";")
    
    if (style_name == "table_stub_font_color")
      ret <- paste0("color: ", val, ";")
    
    if (style_name == "table_stub_background")
      ret <- paste0("background-color: ", val, ";")
    
    if (style_name == "table_stub_font_bold") {
      if (val == TRUE)
        ret <- paste0("font-weight: bold;")
      else 
        ret <- paste0("font-weight: normal;")
      
    }
    
    if (style_name == "table_label_row_bold") {
      if (val == TRUE)
        ret <- paste0("font-weight: bold;")
      else 
        ret <- paste0("font-weight: normal;")
      
    }
    
        
  }
  
  
  return(ret)
}



#' @title A style specification for a table cell
#' @description A class to define the style for a cell in a table.  This
#' class can be assigned to the "style" parameter of a \code{\link{define}}
#' function, a \code{\link{stub}} function, or a \code{\link{column_defaults}}  
#' function.  When assigned, the cell style will apply to some or all of the cells 
#' in the relevant columns.  The 
#' "indicator" parameter identifies a column in the table to trigger the style.
#' Alternatively, the "labelrow", "blankrow", or "datarow" shortcuts may be used
#' to identify cells for styling.  
#' @param indicator A keyword or column name to indicate which rows the cell
#' style should be applied to. Valid keywords are "labelrow", "blankrow", or
#' "datarow". To use an indicator column, create a column on the input dataset
#' that has a TRUE value for each row that you want the cell style applied.
#' Then pass the name of the column to the indicator parameter. If you do not
#' want to see the indicator column on the report, set the "visible" property 
#' on the \code{\link{define}} function to FALSE for that column. 
#' The default value of the indicator parameter is NULL, 
#' meaning to apply the style to all rows.
#' @param bold Whether to bold the text in the cell.  Valid values are TRUE and
#' FALSE.  The default is FALSE.
#' @examples 
#' library(reporter)
#' library(magrittr)
#'
#' # Create temporary path
#' tmp <- file.path(tempdir(), "table1.rtf")
#' 
#' # Prepare data
#' df <- data.frame(names = rownames(mtcars), mtcars[, 1:3])
#' 
#' # Set indicator variable
#' df$mpgind <- ifelse(df$mpg > 20, TRUE, FALSE)
#' 
#' # Create table
#' tbl <- create_table(df, first_row_blank = TRUE, 
#'                     header_bold = TRUE, borders = c("top", "bottom")) %>% 
#'   column_defaults(style = cell_style(bold = TRUE, indicator = "mpgind")) %>%
#'   define(names, label = "Car Name") %>%
#'   define(mpg, label = "Miles Per Gallon") %>% 
#'   define(cyl, label = "Cylinders") %>% 
#'   define(disp, label = "Displacement")  %>% 
#'   define(mpgind, visible = FALSE) %>%
#'   titles("Table 1.0", "MTCARS with Indicator Variable", 
#'          borders = "none", bold = TRUE, font_size = 11) %>% 
#'   footnotes("* Motor Trend, 1974", borders = "none", blank_row = "none")
#' 
#' # Create report and add custom style
#' rpt <- create_report(tmp, output_type = "RTF", font = "Arial") %>% 
#'   add_content(tbl) 
#' 
#' # Write out report
#' write_report(rpt)
#' 
#' # View report
#' # file.show(tmp)
#' @export
cell_style <- function(indicator = NULL, bold = FALSE) {
  
  ret <- structure(list(), class = c("cell_style", "list"))
  
  
  # Deal with single value unquoted parameter values
  oindicator <- deparse(substitute(indicator, env = environment()))
  indicator  <- tryCatch({if (typeof(indicator) %in% c("character", "NULL")) indicator else oindicator},
                 error = function(cond) {oindicator})
  
  
  ret$indicator <- indicator
  ret$bold <- bold
  
  
  return(ret)
  
}


has_cell_style <- function(colnm, styles) {
  
 ret <- FALSE  
 if (colnm %in% names(styles)) {
   
   ret <- TRUE
   
 }
  
 return(ret)
}


get_cell_style <- function(colnm, styles) {
  
  ret <- NULL
  if (has_cell_style(colnm, styles)) {
    
    ret <- styles[[colnm]]
  }
  
  
  return(ret)
}


# Return vector of strings saying which styles to apply to this cell
get_cell_styles <- function(colnm, styles, flgs, rw, tbl) {
  
  ret <- ""
  bflg <- FALSE
  
  if (has_cell_style(colnm, styles)) {
    stl <- get_cell_style(colnm, styles)
    if (stl$bold == TRUE) {
      bflg <- TRUE
      if (!is.null(stl$indicator)) {
        if ("datarow" %in% stl$indicator &&
            flgs[rw] %in% c("B", "L")) {
          bflg <- FALSE
        } else if ("labelrow" %in% stl$indicator &&
                   !flgs[rw] %in% "L") {
          bflg <- FALSE
        } else if ("blankrow" %in% stl$indicator &&
                   !flgs[rw] %in% "B") {
          bflg <- FALSE
        } else if (stl$indicator %in% names(tbl)) {
          if (!is.null(tbl[[rw, stl$indicator]])) {
            bflg <- FALSE 
            if (!is.na(tbl[[rw, stl$indicator]])) {
              if (tbl[[rw, stl$indicator]] == TRUE) {
                bflg <- TRUE   
              }
            }
          }
        }
      } 
    }
  }
  
  if (bflg) {
    ret[length(ret) + 1] <- "bold" 
  }
  
  return(ret)
  
}

