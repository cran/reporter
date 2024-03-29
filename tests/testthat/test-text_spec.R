
context("Text Spec Tests")


test_that("create_text parameter checks work as expected.", {
  
  expect_error(create_text(NULL))
  
  expect_error(create_text(1))
  
  expect_error(create_text("hello", align = "fork"))
  
  expect_error(create_text("Hello", width = - 4))
               
               
  
})

test_that("text print() function works as expected.", {
  
  txt <- create_text("Hello", width = 2, align = "center") %>% 
    titles("Test Title") %>% 
    footnotes("Test footnote")
  
  #print(txt)
  
  #print(txt, verbose = TRUE)
  
  expect_equal(TRUE, TRUE)
  
})


test_that("split_text() works as expected.", {
  
  cnt <- paste0("Lorem ipsum dolor sit amet, consectetur adipiscing elit, ",
                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
                "nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in ", 
                "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ",
                "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa ",
                "qui officia deserunt mollit anim id est laborum.")
  
  
  res <- split_text(cnt, 4, 5, "Arial", 12, "inches")
  
  res
  expect_equal(length(res$text), 2)
  expect_equal(length(res$widths), 2)
  expect_equal(length(res$widths[[1]]), 4)
  expect_equal(length(res$widths[[2]]), 3)
  
  res <- split_text(cnt, 4, 3, "Arial", 12, "inches", 2)
  
  res
  expect_equal(length(res$text), 4)
  expect_equal(length(res$lines), 4)
  expect_equal(length(res$widths), 4)
  expect_equal(res$lines[[1]], 2)
  expect_equal(res$lines[[2]], 4)
  expect_equal(res$lines[[3]], 4)
  expect_equal(res$lines[[4]], 3)
  
  
  cnt2 <- paste0("Lorem ipsum dolor sit amet,\n consectetur adipiscing elit, ",
                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
                "nisi ut aliquip ex ea commodo consequat.\n Duis aute irure dolor \nin ", 
                "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ",
                "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa ",
                "qui officia deserunt\n mollit anim id est laborum.")


  res <- split_text(cnt2, 4, 5, "Arial", 12, "inches")

  res
  
  expect_equal(length(res), 3)
  expect_equal(length(res$text), 3)
  expect_equal(length(res$lines), 3)
  expect_equal(length(res$widths), 3)
  expect_equal(res$lines[[1]], 4)
  expect_equal(res$lines[[2]], 4)
  expect_equal(res$lines[[3]], 2)
  
  res <- split_text(cnt2, 4, 5, "Arial", 12, "inches", 2)
  
  res
  
  expect_equal(length(res), 3)
  expect_equal(length(res$text), 3)
  expect_equal(length(res$lines), 3)
  expect_equal(length(res$widths), 3)
  expect_equal(res$lines[[1]], 2)
  expect_equal(res$lines[[2]], 4)
  expect_equal(res$lines[[3]], 4)
  
})


test_that("get_text_body_pdf() works as expected.", {
  
  cnt2 <- paste0("Lorem ipsum dolor sit amet, consectetur adipiscing elit, ",
                 "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                 "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
                 "nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in ", 
                 "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ",
                 "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa ",
                 "qui officia deserunt mollit anim id est laborum.")
  
  txt <- create_text(cnt2) %>% 
    titles("Here is a title")
  
  rpt <- create_report("", "PDF", font = "Arial", font_size = 12)
  
  rpt <- page_setup_pdf(rpt)
  
  res <- get_text_body_pdf(rpt, txt, 6, 20, 0, FALSE, "center", 25) 
  res
  
  expect_equal(length(res$lines), 1)
  expect_equal(res$lines[1], 8)
  
  
  res <- get_text_body_pdf(rpt, txt, 6, 5, 0, FALSE, "center", 25) 
  res
  
  expect_equal(length(res$lines), 2)
  expect_equal(res$lines[1], 5)
  expect_equal(res$lines[2], 5)
  
})
