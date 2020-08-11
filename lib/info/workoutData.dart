class WorkoutData {
  static List<dynamic> gymList = [["Weight Lifting: general","ยกน้ำหนัก: ทั่วไป",1.544117647,"3.448529412","no","gym"],
    ["Aerobics: water","เต้นแอโรบิกในสระน้ำ",2.132352941,"-0.904411765","no","gym"],
    ["Stretching Hatha Yoga","โยคะ",2.132352941,"-0.904411765","no","gym"],
    ["Calisthenics: moderate","คาลิสต์เทนิค:ปานกลาง",2.426470588,"-3.580882353","no","gym"],
    ["Riders: general","เครื่องไรเดอร์: ทั่วไป",2.647058824,"-0.088235294","no","gym"],
    ["Aerobics: low impact","แอโรบิก: เบา",2.867647059,"3.404411765","no","gym"],
    ["Stair Step Machine: general","เครื่องสเต็ปแมชชีน: ทั่วไป",3.161764706,"0.727941177","no","gym"],
    ["Teaching aerobics","สอนเต้นแอโรบิก",3.161764706,"0.727941177","no","gym"],
    ["Weight Lifting: vigorous","ยกน้ำหนัก: หนัก",3.161764706,"0.727941177","no","gym"],
    ["Aerobics Step: low impact","เต้นแอโรบิก: เบา",3.75,"-3.625","no","gym"],
    ["Aerobics: high impact","แอโรบิก: หนัก",3.75,"-3.625","no","gym"],
    ["Bicycling Stationary: moderate","ปั่นจักรยานในร่ม: ปานกลาง",3.75,"-3.625","no","gym"],
    ["Rowing Stationary: moderate","เครื่องโรลลิ่งแมชชีน:ปานกลาง",3.75,"-3.625","no","gym"],
    ["Calisthenics: vigorous","คาลิสต์เทนิค: หนัก",4.191176471,"3.360294118","no","gym"],
    ["Circuit Training: general","เซอร์กิตเทรนนิ่ง: ทั่วไป",4.191176471,"3.360294118","no","gym"],
    ["Rowing Stationary: vigorous","เครื่องโรลลิ่งแมชชีน: หนัก",4.485294118,"0.683823529","no","gym"],
    ["Elliptical Trainer: general","วิ่งลู่วิ่ง: ทั่วไป",4.779411765,"-0.992647059","no","gym"],
    ["Ski Machine: general","เครื่องสกีแมชชีน",5.073529412,"-3.669117647","no","gym"],
    ["Aerobics Step: high impact","เต้นแอโรบิก: หนัก",5.294117647,"-0.176470588","no","gym"],
    ["Bicycling Stationary: vigorous","ปั่นจักรยานในร่ม: หนัก",5.514705882,"3.316176471","no","gym"]];

  static List<dynamic> sportsList = [["Billiards","บิลเลียด",1.323529412,"-0.044117647","no","training and sport"],
    ["Bowling","โบว์ลิ่ง",1.544117647,"3.448529412","no","training and sport"],
    ["Dancing: slow, waltz, foxtrot","เต้นรำ (เต้นรำช้าๆ, วอลซ์, ฟ็อกซ์ตรอท)",1.544117647,"3.448529412","no","training and sport"],
    ["Frisbee","จานร่อน",1.544117647,"3.448529412","no","training and sport"],
    ["Volleyball: non-competitive, general play","วอลเลย์บอล: ทั่วไป",1.544117647,"3.448529412","no","training and sport"],
    ["Water Volleyball","วอลเลย์บอลน้ำ",1.544117647,"3.448529412","no","training and sport"],
    ["Archery: non-hunting","ยิงธนู (ไม่ใช่การล่าสัตว์)",1.838235294,"0.772058824","no","training and sport"],
    ["Golf: using cart","ตีกอล์ฟ (ใช้รถกอล์ฟ)",1.838235294,"0.772058824","no","training and sport"],
    ["Hang glider","แฮงไกลเดอร์",1.838235294,"0.772058824","no","training and sport"],
    ["Curling","ออกกำลังกายกล้ามเนื้อแขน",2.132352941,"-0.904411765","no","training and sport"],
    ["Gymnastics: general","ยิมนาสติก",2.132352941,"-0.904411765","no","training and sport"],
    ["Horseback Riding: general","ขี่ม้า",2.132352941,"-0.904411765","no","training and sport"],
    ["Tai Chi","ไทชิ",2.132352941,"-0.904411765","no","training and sport"],
    ["Volleyball: competitive, gymnasium play","วอลเลย์บอล: หนัก",2.132352941,"-0.904411765","no","training and sport"],
    ["Walking: (5.63 km/h)","เดิน : (5.63 กม./ชม.)",2.132352941,"-0.904411765","no","training and sport"],
    ["Badminton: general","ตีแบต: ทั่วไป",2.426470588,"-3.580882353","no","training and sport"],
    ["Walking: 6.44 km/hr","เดิน : (6.44 กม./ชม.)",2.426470588,"-3.580882353","no","training and sport"],
    ["Kayaking","พายเรือคายัค",2.647058824,"-0.088235294","no","training and sport"],
    ["Skateboarding","เล่นสเก็ตบอร์ด",2.647058824,"-0.088235294","no","training and sport"],
    ["Snorkeling","ดำน้ำตื้น",2.647058824,"-0.088235294","no","training and sport"],
    ["Softball: general play","ซอฟท์บอล: ทั่วไป",2.647058824,"-0.088235294","no","training and sport"],
    ["Walking: 7.24 km/hr","เดิน : (7.24 กม./ชม.)",2.647058824,"-0.088235294","no","training and sport"],
    ["Whitewater: rafting, kayaking","พายเรือ",2.647058824,"-0.088235294","no","training and sport"],
    ["Dancing: disco, ballroom, square","เต้นรำ (ดิสโก้, ลีลาศ)",2.867647059,"3.404411765","no","training and sport"],
    ["Golf: carrying clubs","ตีกอล์ฟ: แบกไม้เอง",2.867647059,"3.404411765","no","training and sport"],
    ["Dancing: Fast, ballet, twist","เต้นรำ(เร็ว, บัลเล่ย์, ทวิสต์)",3.161764706,"0.727941177","no","training and sport"],
    ["Fencing","การเล่นฟันดาบ",3.161764706,"0.727941177","no","training and sport"],
    ["Hiking: cross-country","การเดินผ่านป่าและทุ่งนา",3.161764706,"0.727941177","no","training and sport"],
    ["Skiing: downhill","สกี: ลงเขา",3.161764706,"0.727941177","no","training and sport"],
    ["Swimming: general","ว่ายน้ำ: ทั่วไป",3.161764706,"0.727941177","no","training and sport"],
    ["Walk/Jog: jog <10 min.","เดิน/จ๊อก: น้อยกว่า 10 นาที",3.161764706,"0.727941177","no","training and sport"],
    ["Water Skiing","สกีน้ำ",3.161764706,"0.727941177","no","training and sport"],
    ["Wrestling","มวยปล้ำ",3.161764706,"0.727941177","no","training and sport"],
    ["Basketball: wheelchair","บาสเกตบอล: บนรถเข็น",3.455882353,"-0.948529412","no","training and sport"],
    ["Race Walking","เดินเร็ว",3.455882353,"-0.948529412","no","training and sport"],
    ["Ice Skating: general","ไอซ์สเก็ต: ทั่วไป",3.75,"-3.625","no","training and sport"],
    ["Racquetball: casual, general","แร็กเก็ต: ทั่วไป",3.75,"-3.625","no","training and sport"],
    ["Rollerblade Skating","โรลเลอร์เบลด",3.75,"-3.625","no","training and sport"],
    ["Scuba or skin diving","ดำน้ำสกูบา",3.75,"-3.625","no","training and sport"],
    ["Soccer: general","ซอคเกอร์: ทั่วไป",3.75,"-3.625","no","training and sport"],
    ["Tennis: general","เทนนิส: ทั่วไป",3.75,"-3.625","no","training and sport"],
    ["Basketball: playing a game","บาสเกตบอล",4.191176471,"3.360294118","no","training and sport"],
    ["Bicycling: 12-13.9 mph","ปั่นจักระยาน",4.191176471,"3.360294118","no","training and sport"],
    ["Football: touch, flag, general","ฟุตบอล (รักบี้)",4.191176471,"3.360294118","no","training and sport"],
    ["Hockey: field & ice","ฮอกกี้",4.191176471,"3.360294118","no","training and sport"],
    ["Rock Climbing: rappelling","ปีนหน้าผา (ใช้เชือก)",4.191176471,"3.360294118","no","training and sport"],
    ["Running: 8 km/hr","วิ่ง : (8 กม./ชม.)",4.191176471,"3.360294118","no","training and sport"],
    ["Running: pushing wheelchair, marathon wheeling","วิ่ง: ดันรถเข็น, มาราธอน",4.191176471,"3.360294118","no","training and sport"],
    ["Skiing: cross-country","สกี: ผ่านป่าและทุ่งนา",4.191176471,"3.360294118","no","training and sport"],
    ["Swimming: backstroke","ว่ายน้ำ: หลัง",4.191176471,"3.360294118","no","training and sport"],
    ["Volleyball: beach","วอลเลย์บอลชายหาด",4.191176471,"3.360294118","no","training and sport"],
    ["Bicycling: BMX or mountain","ปั่นจักระยาน (BMX, เสือภูเขา)",4.485294118,"0.683823529","no","training and sport"],
    ["Boxing: sparring","ต่อยมวย: ซ้อม",4.779411765,"-0.992647059","no","training and sport"],
    ["Football: competitive","ฟุตบอล: แข่งขัน",4.779411765,"-0.992647059","no","training and sport"],
    ["Running: 8.37 km/hr","วิ่ง: (8.37 กม./ชม.)",4.779411765,"-0.992647059","no","training and sport"],
    ["Running: cross-country","วิ่ง: ผ่านป่าและทุ่งนา",4.779411765,"-0.992647059","no","training and sport"],
    ["Bicycling: 22.5 - 25.6 km/hr","ปั่นจักระยาน (22.5 - 25.6 กม./ชม.)",5.294117647,"-0.176470588","no","training and sport"],
    ["Martial Arts: judo, karate, kickbox","ศิลปะป้องกันตัว(ยูโด, คาราเต้)",5.294117647,"-0.176470588","no","training and sport"],
    ["Racquetball: competitive","แร็กเก็ต: แข่งขัน",5.294117647,"-0.176470588","no","training and sport"],
    ["Rope Jumping","กระโดดเชือก",5.294117647,"-0.176470588","no","training and sport"],
    ["Running: 9.66 km/hr","วิ่ง: (9.66 กม./ชม.)",5.294117647,"-0.176470588","no","training and sport"],
    ["Swimming: breaststroke","ว่ายน้ำ: ช่วงอก",5.294117647,"-0.176470588","no","training and sport"],
    ["Swimming: laps, vigorous","ว่ายน้ำไปกลับ: หนัก",5.294117647,"-0.176470588","no","training and sport"],
    ["Swimming: treading, vigorous","ว่ายน้ำลอยตัว: หนัก",5.294117647,"-0.176470588","no","training and sport"],
    ["Water Polo","โปโลน้ำ",5.294117647,"-0.176470588","no","training and sport"],
    ["Rock Climbing: ascending","ปีนหน้าผา (ปีนขึ้น)",5.808823529,"0.639705882","no","training and sport"],
    ["Running: 10.8 km/hr","วิ่ง: (10.8 กม./ชม.)",5.808823529,"0.639705882","no","training and sport"],
    ["Swimming: butterfly","ว่ายน้ำท่าผีเสื้อ",5.808823529,"0.639705882","no","training and sport"],
    ["Swimming: crawl","ว่ายน้ำท่าฟรีสไตล์",5.808823529,"0.639705882","no","training and sport"],
    ["Bicycling: 16-19 mph","ปั่นจักระยาน (25.8-30.6 กม./ชม.)",6.397058824,"-3.713235294","no","training and sport"],
    ["Handball: general","แฮนด์บอล: ทั่วไป",6.397058824,"-3.713235294","no","training and sport"],
    ["Running: 7.5 mph (8 min/mile)","วิ่ง: (12.1 กม./ชม.)",6.617647059,"-0.220588235","no","training and sport"],
    ["Running: 8.6 mph (7 min/mile)","วิ่ง: (13.8 กม./ชม.)",7.720588235,"-3.757352941","no","training and sport"],
    ["Bicycling: > 32.2 km/hr","ปั่นจักระยาน (มากกว่า 32.2 กม./ชม.)",8.75,"-1.125","no","training and sport"],
    ["Running: 16.1 km/hr","วิ่ง: (16.1 กม./ชม.)",8.75,"-1.125","no","training and sport"]];

  static List<dynamic> outdoorList = [["Planting seedlings, shrubs","ปลูกต้นไม้: ต้นกล้า",2.132352941,"-0.904411765","no","outdoor"],
    ["Raking Lawn","พรวนดินในสวน",2.132352941,"-0.904411765","no","outdoor"],
    ["Sacking grass or leaves","ตัดหญ้า",2.132352941,"-0.904411765","no","outdoor"],
    ["Gardening: general","ทำสวน: ทั่วไป",2.426470588,"-3.580882353","no","outdoor"],
    ["Mowing Lawn: push, power","ตัดหญ้า: เครื่องตัดหญ้า",2.426470588,"-3.580882353","no","outdoor"],
    ["Operate Snow Blower: walking","ใช้เครื่องละลายหิมะ",2.426470588,"-3.580882353","no","outdoor"],
    ["Plant trees","ปลูกต้นไม้",2.426470588,"-3.580882353","no","outdoor"],
    ["Gardening: weeding","กำจัดวัชพืช",2.426470588,"1.419117647","no","outdoor"],
    ["Carrying & stacking wood","แบกไม้",2.647058824,"-0.088235294","no","outdoor"],
    ["Digging, spading dirt","ขุดดิน",2.647058824,"-0.088235294","no","outdoor"],
    ["Mowing Lawn: push, hand","ตัดหญ้า: ด้วยมือ",2.867647059,"3.404411765","no","outdoor"],
    ["Chopping & splitting wood","ตัดไม้",3.161764706,"0.727941177","no","outdoor"],
    ["Shoveling Snow: by hand","ขุดหิมะ",3.161764706,"0.727941177","no","outdoor"]];
}
