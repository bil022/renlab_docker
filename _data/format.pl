#!/usr/bin/perl

while (<DATA>) { next if /^#/;
  if (/name: \"(.+)\"/) { $name=$1; }
  elsif (/^position: (.+)/) { $pos=$1; }
  elsif (/^year: (\S+)/) { s/\"//g; $year=$1; }
  elsif (/^prev_position: (.+)/) { $pos1=$1; }
  elsif (/^curr_position: (.+)/) { $pos2=$1; }
  elsif (/(\S+\@\S+)/) { $email=$1; }
  elsif (/^$/) { 
    print "$name;$pos;$email\n" if $pos;
    print "$name;$year;$pos1;$pos2\n" if $pos1;
    undef $_ for $name, $year, $pos, $pos1, $pos2, $email;
  } else { die $_; }
}

__END__
- name: "Lei Chang"
position: Postdotoral Fellow
lec008@health.ucsd.edu

- name: "Songpeng Zu"
position: Postdoctoral Fellow
szu@health.ucsd.edu

- name: "Zane Gibbs"
position: Postdoctoral Fellow
zgibbs@health.ucsd.edu

- name: "Zhaoning Johnny Wang"
position: Postdoctoral Fellow
zhw063@health.ucsd.edu

- name: "Yang Xie"
position: Graduate Student
y2xie@health.ucsd.edu

- name: "Bojing Blair Jia"
position: MSTP Student
b2jia@ucsd.edu

- name: "Luisa Amaral"
position: Graduate Student
lamaral@eng.ucsd.edu

- name: "Adam Jussila"
position: Graduate Student
apjussil@eng.ucsd.edu

- name: "Melodi Tastemel"
position: Postdoctoral Fellow
mtastemel@ucsd.edu

- name: "Samantha Kuan"
position: Lab Manager
sakuan@ucsd.edu

- name: "Bin Li"
position: Postgraduate Researcher
bil022@ucsd.edu

- name: "Bernadeth Torres"
position: Laboratory Administrator
bet003@ucsd.edu

- name: "Naoki Kubo"
year: "2016-2021"
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Kyushu University

- name: "Guoqiang Jason Li"
year: "2015-2021"
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Peking University

- name: "Ramya Raviram"
year: "2017-2020"
prev_position: Postdoctoral Fellow
curr_position: Postdoctoral Fellow, Weill Cornell

- name: "Miao Yu"
year: "2015-2020"
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Fudan University

- name: "Shan Mandy Jiang"
year: 2019-2020
prev_position: Postdoctoral Fellow
curr_position: Bioinformatics Scientist, AccuraGen.

- name: "Haruhiko Ishii"
year: 2008-2020
prev_position: Research Scientist
curr_position: Scientist, Fate Therapeutics Inc.

- name: "Quan Zhu"
year: "2018-2019"
prev_position: Research Scientist
curr_position: Associate Director, Epigenomics Center @UCSD

- name: "Yarui Diao"
year: "2013-2018"
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Duke University

- name: "Jian Yan"
year: "2015-2018"
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, City University of Hong Kong

- name: "Sebastian Preissl"
year: 2015-2017
prev_position: Postdoctoral Fellow
curr_position: Associate Director, Epigenomics Center @UCSD

- name: "David Gorkin"
year: 2013-2017
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Emory University

- name: "Inkyung Jung"
year: 2012-2016
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, KAIST

- name: "Danny Leung"
year: 2012-2015
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Hong Kong Univ. Science & Technology

- name: "Wei Xie"
year: 2009-2013
prev_position: Postdoctoral Fellow
curr_position: Professor, Tsinghua University

- name: "Yan Li"
year: 2009-2015
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, Case Western Reserve University

- name: "Tingting Du"
year: 2008-2015
prev_position: Postdoctoral Fellow
curr_position: Oncology Scientist, Illunima

- name: "Yin Shen"
year: 2008-2014
prev_position: Postdoctoral Fellow
curr_position: Assistant Professor, UCSF

- name: "Feng Yue"
year: 2008-2013
prev_position: Postdoctoral Fellow
curr_position: Associate Professor, Northwestern University

- name: "Celso A. Espinoza"
prev_position: Postdoctoral Fellow
year: 2007-2014
curr_position: Senior scientist II, AbbVie

- name: "Fulai Jin"
prev_position: Postdoctoral Fellow
year: 2007-2014
curr_position: Assistant Professor, Case Western Reserve University

- name: "Andrea Local "
prev_position: Postdoctoral Fellow
year: 2007-2014
curr_position: Senior scientist, Celgene

- name: "R. David Hawkins"
year: 2005-2010
prev_position: Postdoctoral Fellow
curr_position: Associate Professor, U. Washington, Seattle

- name: "Zirong Li"
year: "2002-2007"
prev_position: Postdoctoral Fellow
curr_position: Scientist, Millipore

- name: "Kun Wang"
year: "2003-2005"
prev_position: Postdoctoral Fellow
curr_position: Patent Attorney at GNF

- name: "Tae Hoon Kim"
year: "2002-2006"
prev_position: Postdoctoral Fellow
curr_position: Associate Professor, University of Texas at Dallas

# Graduate Student
- name: "Rongxin Fang"
year: 2015-2019
prev_position: Graduate Student
curr_position: Postdoctoral fellow, Harvard University

- name: "Yunjiang Qiu"
year: 2014-2019
prev_position: Graduate Student
curr_position: Scientist, Illunima


- name: "Anugraha Raman"
year: 2013-2019
prev_position: Graduate Student
curr_position: Associate Scientist, Computational Biology at Fulcrum Therapeutics

- name: "Yuan Zhao"
year: 2015-2019
prev_position: Graduate Student
curr_position: Data Scientist, Encoded Therapeutics

- name: "Anthony Schmitt"
year: 2012-2016
prev_position: Graduate Student
curr_position: Vice President, Research and Development at Arima Genomics, Inc.

- name: "Siddarth Selvaraj"
year: 2011-2014
prev_position: Graduate Student
curr_position: Founder and CEO, Arima Genomics, Inc.

- name: "Jesse Dixon"
year: 2009-2013
prev_position: Graduate Student
curr_position: Fellow, Salk Institute

- name: "Chloe Rivera"
year: 2009-2015
prev_position: Graduate Student
curr_position: Engagement Manager at McKinsey & Co

- name: "Nisha Rajagopal"
year: 2009-2013
prev_position: Graduate Student
curr_position: Senior Scientist, Syros Pharmaceuticals

- name: "Gary Hon"
year: 2004-2009(PhD)-2014
prev_position: Graduate Student & Postdoc
curr_position: Assistant Professor, UT Southwestern

- name: "Saurabh Agarwal"
year: 2005-2011
prev_position: Graduate Student
curr_position: Postdoc at University of Michigan

- name: "Leah O. Barrera"
year: 2003-2007
prev_position: Graduate Student
curr_position: Scientist, Ambit Biosciences

- name: "Nathaniel Maynard"
year: 2002-2008
prev_position: Graduate Student
curr_position: Senior Scientist, Synthetic Genomics

- name: "Nathaniel D. Heintzman"
year: 2002-2007
prev_position: Graduate Student
curr_position: Director, Data Partnerships, Dexcom,Inc.


# Research Associate
- name: "Rong Hu"
prev_position: Research Associate

- name: "Sora Chee"
prev_position: Research Associate
curr_position: Medical student

- name: "Tristin Liu"
prev_position: Research Associate
curr_position: Master's student

- name: "Ah Young Lee"
prev_position: Research Associate
curr_position: PhD student, John's Hopkins University

- name: "Chia-An Yen"
year: 2012-2014
prev_position: Research Associate
curr_position: PhD student, University of Southern California

- name: "Lee Esall"
year: 2007-2013
prev_position: Research Associate/Bioinformatician
curr_position: Research Fellow, Cincinnati Children's Medical Center

- name: "Lindsey Harp"
year: 2006-2008
prev_position: Research Associate
curr_position: Technical Sales Specialist, Thermo Fisher Scientific

- name: "Leonard Lee"
year: 2005-2009
prev_position: Research Associate
curr_position: Resident Physician, Wheaton Franciscan Healthcare

- name: "Rhona Stuart"
year: 2003-2007
prev_position: Research Associate
curr_position: Postdoctoral Researcher at Lawrence Livermore National Laboratory

- name: "Sarah Van Calcar"
year: 2001-2006
prev_position: Research Associate
curr_position: Assistant Professor of Clinical Medicine, Hospital of the University of Pennsylvania

