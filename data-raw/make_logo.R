## code to prepare hex
library(magick)
library(bunny)

pkglogo <- image_read("data-raw/prereview-logo.png") %>%
  image_resize("55%", filter = "Lanczos2")
pkglogo

bg_color <- "#ffffff"
bg_color2 <- "#F4FFFD"
fg_color <- "#465362"
txt_color <- "#011936"

prrw_hex <-
  image_canvas_hex(fill_color = bg_color, border_color = fg_color) %>%
  image_compose(pkglogo, gravity = "center") %>%
  image_composite(image_canvas_hexborder(border_color = fg_color, border_size = 5),
                  gravity = "center", operator = "Atop")

prrw_hex %>% image_scale("30%")

prrw_hex %>%
  image_scale("1200x1200") %>%
  image_write("data-raw/prereviewr_hex.png", density = 600)

prrw_hex %>%
  image_scale("200x200") %>%
  image_write("man/figures/logo.png", density = 600)

prrw_hex_gh <- prrw_hex %>%
  image_scale("400x400")

gh_logo <- bunny::github %>%
  #image_negate() %>%
  image_scale("40x40")

prrw_ghcard <-
  image_canvas_ghcard(fill_color = bg_color2) %>%
  image_composite(prrw_hex_gh, gravity = "East", offset = "+100+0") %>%
  image_annotate("Empowering the preprints", gravity = "West", location = "+60-30",
                 color=txt_color, size=45, font="Aller", weight = 400) %>%
  image_compose(gh_logo, gravity="West", offset = "+60+40") %>%
  image_annotate("dmi3kno/prereviewr", gravity="West", color=fg_color,
                 location="+120+40", size=45, font="Ubuntu Mono") %>%
  image_border_ghcard(bg_color2)

prrw_ghcard %>% image_scale("30%")


prrw_ghcard %>%
  image_write("data-raw/prereviewr_ghcard.png", density = 600)
