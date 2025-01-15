return {
  { "nvzone/timerly", cmd = "TimerlyToggle" },
  { "nvzone/menu", lazy = true },
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      -- more opts
    },
  },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "nvzone/typr",
    cmd = "TyprStats",
    dependencies = "nvzone/volt",
    opts = {},
  },
}
