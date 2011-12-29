require 'rubygems'

class NongLi
  @@lunarInfo = [0x04bd8, 0x04ae0, 0x0a570,
    0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
    0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0,
    0x0ada2, 0x095b0, 0x14977, 0x04970, 0x0a4b0, 0x0b4b5, 0x06a50,
    0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566,
    0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0,
    0x1c8d7, 0x0c950, 0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4,
    0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0, 0x0b550,
    0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950,
    0x06aa0, 0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260,
    0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0, 0x04dd5, 0x04ad0,
    0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
    0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40,
    0x0af46, 0x0ab60, 0x09570, 0x04af5, 0x04970, 0x064b0, 0x074a3,
    0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960,
    0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0,
    0x092d0, 0x0cab5, 0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9,
    0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954, 0x06aa0,
    0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65,
    0x0d530, 0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0,
    0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0, 0x056d0, 0x055b2,
    0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0 ]

  @@year20 = [1, 4, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1 ]
  @@year19 = [ 0, 3, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0 ]
  @@year2000 = [0, 3, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1 ]
  @@nStr1 = ["","正","二","三","四","五","六","七","八","九","十","十一","十二"]

  @@gan= ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
  @@zhi= ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
  @@shuxiang = ["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"]
  @@holiday = [
    ["0101", "元旦", 1],
    ["0214", "情人节", 0],
    ["0308", "妇女节", 0],
    ["0312", "植树节", 0],
    ["0315", "消费者权益日", 0],
    ["0401", "愚人节", 0],
    ["0501", "劳动节", 1],
    ["0504", "青年节", 0],
    ["0512", "护士节", 0],
    ["0601", "儿童节", 0],
    ["0808", "父亲节", 0],
    ["0910", "教师节", 0],
    ["0928", "孔子诞辰", 0],
    ["1001", "国庆节", 1],
    ["1006", "老人节", 0],
    ["1024", "联合国日", 0],
    ["1112", "孙中山诞辰", 0],
    ["1225", "圣诞节", 0]
  ]
  @@nongli_holiday = [
    ["0101", "春节", 1],
    ["0115", "元宵节", 0],
    ["0505", "端午节", 0],
    ["0707", "七夕情人节", 0],
    ["0815", "中秋节", 0],
    ["0909", "重阳节", 0],
    ["1208", "腊八节", 0],
    ["0100", "除夕", 1]
  ]
  @@date = Date.today
  @@nongli_year = ""
  @@nongli_month = 0
  @@nongli_day = 0
  @@nongli_run = 0
  #传出y年m月d日对应的农历.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6

  def initialize(d = Date.today)
    @@date = d
    year = @@date.year
    month = @@date.month
    date = @@date.day
    l = calElement(year, month, date)
    @@nongli_year = l[0]
    @@nongli_month = l[1]
    @@nongli_day = l[2]
    @@nongli_run = l[6]
  end

  #农历 年份
  def year
    return cyclical(@@nongli_year) 
  end

  #农历月份
  def month
    return (@@nongli_run == 1 ? "闰" : "") + @@nStr1[@@nongli_month] + "月" 
  end 

  #农历日
  def day
    return getChinaDate(@@nongli_day)
  end

  #返回节日，如果有多个节日，逗号分割
  def holidays
    names = ""
    #查询公历节日
    md = ""
    if(@@date.month < 10)
      md = "0" + @@date.month.to_s()
    else
      md = @@date.month.to_s()
    end
    if(@@date.day < 10)
      md += "0" + @@date.day.to_s()
    else
      md += @@date.day.to_s()
    end
    for h in @@holiday
      if(h[0] == md)
        names += h[1] + " "
      end
    end

    #查询农历节日
    md = ""
    if(@@nongli_month.to_i() < 10)
      md = "0" + @@nongli_month.to_s()
    else
      md = @@nongli_month.to_s()
    end
    if(@@nongli_day.to_i() < 10)
      md += "0" + @@nongli_day.to_s()
    else
      md += @@nongli_day.to_s()
    end
    for h in @@nongli_holiday
      if(h[0] == md)
        names += h[1] + " "
      end
    end


    return names
  end

  #查询是否需要变红的重大节日 0，不是； 1，是
  def isImportantHoliday
    #查询公历节日
    md = ""
    if(@@date.month < 10)
      md = "0" + @@date.month.to_s()
    else
      md = @@date.month.to_s()
    end
    if(@@date.day < 10)
      md += "0" + @@date.day.to_s()
    else
      md += @@date.day.to_s()
    end
    for h in @@holiday
      if(h[0] == md && h[2] == 1)
        return 1
      end
    end

    #查询农历节日
    md = ""
    if(@@nongli_month.to_i() < 10)
      md = "0" + @@nongli_month.to_s()
    else
      md = @@nongli_month.to_s()
    end
    if(@@nongli_day.to_i() < 10)
      md += "0" + @@nongli_day.to_s()
    else
      md += @@nongli_day.to_s()
    end
    for h in @@nongli_holiday
      if(h[0] == md && h[2] == 1)
      end
    end
    return 0
  end

  #返回生肖
  def shengxiao
    return shengxiaoYear(@@nongli_year)
  end

  def to_s
    year = @@date.year
    month = @@date.month
    date = @@date.day
    l = calElement(year, month, date)
    sDay = year.to_s() + "/" + month.to_s() + "/" + date.to_s()  + "  (" + l[0].to_s() + "-" + l[1].to_s() + "-" + l[2].to_s() + "-" + l[3].to_s() + "-" + l[4].to_s() + "-" + l[5].to_s() + "-" + l[6].to_s() + ")"
    sDay += "农历 " + cyclical(@@nongli_year) 
    sDay +=  "年（" + shengxiaoYear(@@nongli_year) + "） " 
    sDay += @@nongli_run == 1 ? "闰" : ""
    sDay += @@nStr1[@@nongli_month] + "月" 
    sDay += getChinaDate(@@nongli_day) 
    return sDay
  end

  #传回农历 y年的总天数
  def lYearDays(y)
    sum = 348
    i = 0x8000
    while i > 0x8
      if ((@@lunarInfo[y - 1900] & i) != 0)
        sum += 1
      end
      i >>= 1
    end
    return (sum + leapDays(y))
  end

  #传回农历 y年闰月的天数
  def leapDays(y) 
    if (leapMonth(y) != 0) 
      if ((@@lunarInfo[y - 1900] & 0x10000) != 0)
        return 30
      else
        return 29
      end
    else
      return 0
    end
  end

  #传回农历 y年闰哪个月 1-12 , 没闰传回 0
  def leapMonth(y)
    return (@@lunarInfo[y - 1900] & 0xf)
  end


  #传回农历 y年m月的总天数
  def  monthDays(y, m)
    if ((@@lunarInfo[y - 1900] & (0x10000 >> m)) == 0)
      return 29
    else
      return 30
    end
  end

  #传回农历 y年的生肖
  def shengxiaoYear(y)
    return @@shuxiang[(y - 4) % 12]
  end

  #传入 月日的offset 传回干支,0=甲子
  def cyclicalm(num)
    return (@@gan[num % 10] + @@zhi[num % 12])
  end

  #传入 offset 传回干支, 0=甲子
  def cyclical(y)
    num = y - 1900 + 36
    return (cyclicalm(num))
  end

  #传出农历.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
  def Lunar(y, m)
    #long[] nongDate = new long[7];
    nongDate = []
    i = 0
    temp = 0
    leap = 0
    baseDate = Date.new(1900+1900, 1, 31)
    objDate = Date.new(y+1900, m, 1);
    offset = objDate - baseDate
    if (y < 2000)
      offset += @@year19[m - 1]
    elsif (y > 2000)
      offset += @@year20[m - 1]
    elsif (y == 2000)
      offset += @@year2000[m - 1]
    end

    nongDate[5] = offset + 40
    nongDate[4] = 14

    i = 1900
    while (i < 2050 && offset > 0)
      temp = lYearDays(i)
      offset -= temp
      nongDate[4] += 12

      i += 1
    end
    if (offset < 0) 
      offset += temp
      i -= 1
      nongDate[4] -= 12
    end
    nongDate[0] = i
    nongDate[3] = i - 1864
    leap = leapMonth(i) # 闰哪个月
    nongDate[6] = 0

    i=1
    while(i<13 && offset > 0)
      #闰月
      if (leap > 0 && i == (leap + 1) && nongDate[6] == 0) 
        i -= 1
        nongDate[6] = 1
        temp = leapDays( nongDate[0])
      else
        temp = monthDays( nongDate[0], i)
      end

      #解除闰月
      if (nongDate[6] == 1 && i == (leap + 1))
        nongDate[6] = 0
      end
      offset -= temp;
      if (nongDate[6] == 0 )
        nongDate[4] += 1
      end


      i += 1
    end

    if (offset == 0 && leap > 0 && i == leap + 1) 
      if (nongDate[6] == 1) 
        nongDate[6] = 0
      else
        nongDate[6] = 1
        i -= 1
        nongDate[4] -= 1
      end
    end
    if (offset < 0)  
      offset += temp
      i -= 1
      nongDate[4] -= 1
    end
    nongDate[1] = i
    nongDate[2] = offset + 1

    return nongDate
  end


  #传出y年m月d日对应的农历.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
  def calElement(y, m, d)
    nongDate = []
    i = 0
    temp = 0
    leap = 0
    baseDate = Date.new(0+1900, 1, 31)

    objDate = Date.new(y, m, d);
    offset = objDate - baseDate
    nongDate[5] = offset + 40;
    nongDate[4] = 14;

    i = 1900
    while (i < 2050 && offset > 0)
      temp = lYearDays(i)
      offset -= temp
      nongDate[4] += 12

      i += 1
    end

    if (offset < 0) 
      offset += temp 
      i -= 1 
      nongDate[4] -= 12 
    end
    nongDate[0] = i
    nongDate[3] = i - 1864
    leap = leapMonth(i) #闰哪个月
    nongDate[6] = 0

    i = 1
    while(i<13 && offset > 0)
      #闰月
      if (leap > 0 && i == (leap + 1) && nongDate[6] == 0) 
        i -= 1
        nongDate[6] = 1
        temp = leapDays( nongDate[0])
      else
        temp = monthDays( nongDate[0], i)
      end

      #解除闰月
      if (nongDate[6] == 1 && i == (leap + 1))
        nongDate[6] = 0
      end
      offset -= temp
      if (nongDate[6] == 0)
        nongDate[4] += 1
      end

      i += 1
    end

    if (offset == 0 && leap > 0 && i == leap + 1) 
      if (nongDate[6] == 1) 
        nongDate[6] = 0
      else
        nongDate[6] = 1
        i -= 1
        nongDate[4] -= 1
      end
    end
    if (offset < 0) 
      offset += temp
      i -= 1
      nongDate[4] -= 1
    end
    nongDate[1] = i
    nongDate[2] = offset + 1

    return nongDate
  end

  def getChinaDate(day) 
    a = ""
    if (day == 10)
      return "初十"
    elsif (day==20)
      return "二十"
    elsif (day==30)
      return "三十"
    end

    two =  ((day) / 10).to_i()

    if (two == 0)
      a = "初"
    elsif (two == 1)
      a = "十"
    elsif (two == 2)
      a = "廿"
    elsif (two == 3)
      a = "三"
    else
      a = "ERROR"
    end
    one =  (day % 10)

    case one
    when 1 then a += "一"
    when 2 then a += "二"
    when 3 then a += "三"
    when 4 then a += "四"
    when 5 then a += "五"
    when 6 then a += "六"
    when 7 then a += "七"
    when 8 then a += "八"
    when 9 then a += "九"
    end

    return a
  end

  #sample计算今天
  def today
    today = Date.today
    year = today.year
    month = today.month
    date = today.date
    l = calElement(year, month, date)
    sToday = year.to_s() + "/" + month.to_s() + "/" + date.to_s() + "  "
    sToday += "农历 " + cyclical(l[0]) + "(" + shengxiaoYear(l[0]) + ")年 " + @@nStr1[l[1]] + "月" + getChinaDate(l[2]) 
    return sToday
  end
end

# d = Date.today
d = Date.new(1982, 11, 23)
print d.to_s + "\n"
nongli = NongLi.new(d)  
print  nongli.year + "[" + nongli.shengxiao + "]年\n"  
print  nongli.month + nongli.day + "\n"  
print  nongli.holidays  
