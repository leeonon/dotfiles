const fs = require("node:fs");
const path = require("node:path");

const { Lunar } = require("./lunar");
const d = Lunar.fromDate(new Date());

const lunar = d.getTimeZhi() + "时";
const yi = d.getDayYi().join(" ");
const ji = d.getDayJi().join(" ");

// 写入临时文件
const tempPath = path.join("/tmp", "TODAY_YIJI_IS");
fs.writeFileSync(tempPath, `${lunar}\n${yi}\n${ji}\n`);

function getTodayYiJi() {
  return {
    lunar,
    yi,
    ji,
  };
}

module.exports = {
  getTodayYiJi,
};
