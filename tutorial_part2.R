# Load packages
library(palmerpenguins)
library(tidyverse)

# Read in data
penguins_raw <- read_csv("data/penguins.csv")

# Inspect data
head(penguins_raw)
glimpse(penguins_raw)
view(penguins_raw)

# Clean data
penguins_clean <- penguins_raw %>%
  select(-V6) %>%
  filter(species != "Err") %>%
  drop_na(sex) %>%
  mutate(across(ends_with("mm"), as.numeric))

# Analysis
penguins_clean %>%
  count(species)

with(penguins_clean, tapply(flipper_length_mm, species, summary))

penguins_clean %>%
  ggplot(aes(species, flipper_length_mm, fill = species)) +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(width = 0.1, alpha = 0.3) +
  labs(
    x = NULL,
    y = NULL,
    title = "Flipper Length by Species"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

flipper_anova <- aov(flipper_length_mm ~ species, data = penguins_clean)
summary(flipper_anova)
TukeyHSD(flipper_anova)

# Write out, cleanup
write_csv(penguins_clean, "data/penguins_clean.csv")
