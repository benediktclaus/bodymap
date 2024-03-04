library(tidyverse)
library(sf)


shape_import <- st_read("data-raw/body-map-rough.shp")


# Remove CRS
st_crs(shape_import) <- NA



# Get dimensions
shape_dims <- st_bbox(shape_import)
height <- shape_dims[["ymax"]] - shape_dims[["ymin"]]

scaling_factor <- height / 150


bodymap <- shape_import |>
    mutate(
        geometry = geometry - c(shape_dims[["xmin"]], shape_dims[["ymin"]]),
        geometry = geometry / scaling_factor
    )

use_data(bodymap, overwrite = TRUE)
