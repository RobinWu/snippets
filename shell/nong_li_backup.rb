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
	@@nStr1 = ["","��","��","��","��","��","��","��","��","��","ʮ","ʮһ","ʮ��"]

	@@gan= ["��","��","��","��","��","��","��","��","��","��"]
	@@zhi= ["��","��","��","î","��","��","��","δ","��","��","��","��"]
	@@shuxiang = ["��","ţ","��","��","��","��","��","��","��","��","��","��"]
	@@holiday = [
		["0101", "Ԫ��", 1],
		["0214", "���˽�", 0],
		["0308", "��Ů��", 0],
		["0312", "ֲ����", 0],
		["0315", "������Ȩ����", 0],
		["0401", "���˽�", 0],
		["0501", "�Ͷ���", 1],
		["0504", "�����", 0],
		["0512", "��ʿ��", 0],
		["0601", "��ͯ��", 0],
		["0808", "���׽�", 0],
		["0910", "��ʦ��", 0],
		["0928", "���ӵ���", 0],
		["1001", "�����", 1],
		["1006", "���˽�", 0],
		["1024", "���Ϲ���", 0],
		["1112", "����ɽ����", 0],
		["1225", "ʥ����", 0]]
	@@nongli_holiday = [
		["0101", "����", 1],
		["0115", "Ԫ����", 0],
		["0505", "�����", 0],
		["0707", "��Ϧ���˽�", 0],
		["0815", "�����", 0],
		["0909", "������", 0],
		["1208", "���˽�", 0],
		["0100", "��Ϧ", 1]]
  @@date = Date.today
  @@nongli_year = ""
  @@nongli_month = 0
  @@nongli_day = 0
  @@nongli_run = 0
  #����y��m��d�ն�Ӧ��ũ��.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6

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
  
  #ũ�� ���
  def year
    return cyclical(@@nongli_year) 
  end

  #ũ���·�
  def month
    return (@@nongli_run == 1 ? "��" : "") + @@nStr1[@@nongli_month] + "��" 
  end 
  
  #ũ����
  def day
    return getChinaDate(@@nongli_day)
  end

  #���ؽ��գ�����ж�����գ����ŷָ�
  def holidays
    names = ""
    #��ѯ��������
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

    #��ѯũ������
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

  #��ѯ�Ƿ���Ҫ�����ش���� 0�����ǣ� 1����
  def isImportantHoliday
    #��ѯ��������
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

    #��ѯũ������
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

  #������Ф
  def shengxiao
    return shengxiaoYear(@@nongli_year)
  end

  def to_s
		year = @@date.year
    month = @@date.month
    date = @@date.day
    l = calElement(year, month, date)
		sDay = year.to_s() + "/" + month.to_s() + "/" + date.to_s()  + "  (" + l[0].to_s() + "-" + l[1].to_s() + "-" + l[2].to_s() + "-" + l[3].to_s() + "-" + l[4].to_s() + "-" + l[5].to_s() + "-" + l[6].to_s() + ")"
    sDay += "ũ�� " + cyclical(@@nongli_year) 
    sDay +=  "�꣨" + shengxiaoYear(@@nongli_year) + "�� " 
    sDay += @@nongli_run == 1 ? "��" : ""
    sDay += @@nStr1[@@nongli_month] + "��" 
    sDay += getChinaDate(@@nongli_day) 
    return sDay
  end

  #����ũ�� y���������
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

  #����ũ�� y�����µ�����
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

  #����ũ�� y�����ĸ��� 1-12 , û�򴫻� 0
  def leapMonth(y)
		return (@@lunarInfo[y - 1900] & 0xf)
	end


  #����ũ�� y��m�µ�������
  def  monthDays(y, m)
		if ((@@lunarInfo[y - 1900] & (0x10000 >> m)) == 0)
			return 29
		else
			return 30
    end
	end

  #����ũ�� y�����Ф
  def shengxiaoYear(y)
		return @@shuxiang[(y - 4) % 12]
	end

  #���� ���յ�offset ���ظ�֧,0=����
  def cyclicalm(num)
		return (@@gan[num % 10] + @@zhi[num % 12])
  end

  #���� offset ���ظ�֧, 0=����
  def cyclical(y)
		num = y - 1900 + 36
		return (cyclicalm(num))
  end
  
  #����ũ��.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
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
		leap = leapMonth(i) # ���ĸ���
		nongDate[6] = 0
    
    i=1
    while(i<13 && offset > 0)
      #����
			if (leap > 0 && i == (leap + 1) && nongDate[6] == 0) 
				i -= 1
				nongDate[6] = 1
				temp = leapDays( nongDate[0])
			else
				temp = monthDays( nongDate[0], i)
			end

			#�������
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


  #����y��m��d�ն�Ӧ��ũ��.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
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
		leap = leapMonth(i) #���ĸ���
		nongDate[6] = 0

    i = 1
    while(i<13 && offset > 0)
			#����
			if (leap > 0 && i == (leap + 1) && nongDate[6] == 0) 
				i -= 1
				nongDate[6] = 1
				temp = leapDays( nongDate[0])
			else
				temp = monthDays( nongDate[0], i)
			end

			#�������
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
			return "��ʮ"
		elsif (day==20)
			return "��ʮ"
		elsif (day==30)
			return "��ʮ"
    end
		
    two =  ((day) / 10).to_i()

    if (two == 0)
			a = "��"
		elsif (two == 1)
			a = "ʮ"
		elsif (two == 2)
			a = "إ"
		elsif (two == 3)
			a = "��"
    else
      a = "ERROR"
    end
		one =  (day % 10)

    case one
      when 1 then a += "һ"
      when 2 then a += "��"
      when 3 then a += "��"
      when 4 then a += "��"
      when 5 then a += "��"
      when 6 then a += "��"
      when 7 then a += "��"
      when 8 then a += "��"
      when 9 then a += "��"
    end

		return a
  end
	
	
  #sample�������
  def today
		today = Date.today
		year = today.year
    month = today.month
    date = today.date
    l = calElement(year, month, date)
		sToday = year.to_s() + "/" + month.to_s() + "/" + date.to_s() + "  "
    sToday += "ũ�� " + cyclical(l[0]) + "(" + shengxiaoYear(l[0]) + ")�� " + @@nStr1[l[1]] + "��" + getChinaDate(l[2]) 
    return sToday
  end
end


d = Date.today
print d.to_s + "\n"
nongli = NongLi.new(d)  
print  nongli.year + "[" + nongli.shengxiao + "]��\n"  
print  nongli.month + nongli.day + "\n"  
print  nongli.holidays  