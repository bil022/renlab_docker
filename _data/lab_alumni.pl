#!/usr/bin/perl

open LAB, ">labmembers.yml" or die "lab?";
open ALU, ">alumni.yml" or die "alu?"; 

while (<DATA>) {
  next if /^name/; chomp;
  if (/\@/) { ($name, $pos, $email)=split(/\t/, $_);
    print LAB "\n- name: \"$name\"\n  position: $pos\n  email: $email\n";
  } else { ($name, $year, $prev, $curr)=split(/\t/, $_);
    print ALU "\n- name: \"$name\"\n  year: \"$year\"\n  prev_position: $prev\n  curr_position: $curr\n";
  }
}
close LAB;
close ALU;

__END__
name	position	email
Keyi Dong	Research Associate	k1dong@ucsd.edu
Audrey Lie	Research Associate	aulie@health.ucsd.edu
Hannah Indralingam	Research Associate	hindralingam@health.ucsd.edu
Timothy Loe	Research Associate	t1loe@health.ucsd.edu
Adam Paul Jussila	Graduate student	apjussil@eng.ucsd.edu
Maria Luisa Amaral	Graduate student	lamaral@eng.ucsd.edu
Bojing (Blair) Jia	Graduate student	b2jia@ucsd.edu
Yang Xie	Graduate student	y2xie@health.ucsd.edu
Ying Yuan	Graduate student	y8yuan@ucsd.edu
Ethan Armand	Graduate student	earmand@ucsd.edu
Sainath Mamde	Graduate student	smamde@ucsd.edu
Jeffrey Chiu	Graduate student	jhc103@health.ucsd.edu
Jenny Dong	Graduate student	wed009@ucsd.edu
Cuiling He	Graduate student	cuhe@health.ucsd.edu
Shivani Lakkaraju	Graduate student	slakkara@health.ucsd.edu
Brett Taylor	Graduate student	b5taylor@health.ucsd.edu
Zane Gibbs	Postdoctoral fellow	zgibbs@health.ucsd.edu
Zhaoning Wang	Postdoctoral fellow	zhw063@health.ucsd.edu
Songpeng Zu	Postdoctoral fellow	szu@health.ucsd.edu
Lei Chang	Postdoctoral fellow	lec008@health.ucsd.edu
Jie Xu	Postdoctoral fellow	jix062@health.ucsd.edu
Seoyeon Lee	Postdoctoral fellow	sel041@health.ucsd.edu
Kangli Wang	Postdoctoral fellow	kaw033@health.ucsd.edu
Bharath Saravanan	Postdoctoral fellow	bsaravanan@ucsd.edu
Kai Li	Postdoctoral fellow	kal084@health.ucsd.edu
Melodi Tastemel	Postdoctoral fellow	mtastemel@health.ucsd.edu
Samantha Kuan	Lab Manager	sakuan@ucsd.edu
Bin Li	Postgraduate Researcher	bil022@ucsd.edu
Bernadeth Torres	Laboratory Administrator	bet003@ucsd.edu
name	year	prev_position	curr_position
Ah Young Lee		Research Associate	PhD student, John's Hopkins University
Andrea Local	2007-2014	Postdoctoral Fellow	Director of Tumor Biology
Anthony Schmitt	2013-2016	Graduate student	Senior VP, Arima Genomics
Anugraha Raman	2013-2019	Graduate Student	Computational Biologist at Accent Therapeutics
Celso A. Espinoza	2007-2014	Postdoctoral Fellow	Senior scientist II, AbbVie Pharmaceuticals
Chenxu Zhu	2017-2022	Postdoctoral Fellow	Assistant Professor, New York Genome Center
Chia-An Yen	2012-2014	Research Associate	PhD student, University of Southern California
Chloe Rivera	2009-2015	Graduate Student	Engagement Manager at McKinsey & Co
Dan Cunningham-Bryant	2019-2021	Postdoctoral Fellow	Research Scientist, Draper Laboratory
Danny Leung	2012-2015	Postdoctoral Fellow	Associate Professor at Hong Kong University of Science and Technology
David Gorkin	2013-2017	Postdoctoral Fellow	Assistant Professor, Emory University
David Hawkins	2005-2010	Postdoctoral Fellow	Associate Professor, University of Washington
Feng Yue	2008-2013	Postdoctoral Fellow	Associate Professor, Northwestern University
Fulai Jin	2007-2014	Postdoctoral Fellow	Assistant Professor, Case Western Reserve University
Gary Hon	2004-2009(PhD)-2014	Graduate Student & Postdoc	Assistant Professor, UT Southwestern
Guoqiang Jason Li	2015-2021	Postdoctoral Fellow	Assistant Professor, Peking University, China
Haruhiko Ishii	2008-2014	Postdoctoral Fellow	Research Scientist, Epigenome Technologies Inc
Hui Huang	2016-2021	Graduate student	Postdoc, Oxford U.
Inkyung Jung	2012-2016	Postdoctoral Fellow	Associate Professor, KAIST University, Korea
James Hocker	2018-2022	Graduate student	MSTP training
Jesse Dixon	2009-2013	Graduate student	Assistant Professor, Salk Institute
Jian Yan	2015-2018	Postdoctoral Fellow	Assistant Professor, City University of Hong Kong
Kai Zhang	2019-2023	Postdoctoral Fellow	Assistant Professor, Westlake University, China
Kun Wang	2003-2005	Postdoctoral Fellow	Patent Attorney at GNF
Leah O. Barrera	2003-2007	Graduate Student	Bioinformatics Director Vir Biotechnology, Inc.
Lee Esall	2007-2013	Research Associate/Bioinformatician	Research Fellow, Cincinnati Children's Medical Center
Leonard Lee	2005-2009	Research Associate	Resident Physician, Wheaton Franciscan Healthcare
Lindsey Harp	2006-2008	Research Associate	Technical Sales Specialist, Thermo Fisher Scientific
Miao Yu	2015-2020	Postdoctoral Fellow	Assistant Professor, Fudan University, China
Naoki Kubo	2016-2021	Postdoctoral Fellow	Research Assistant Professor, Kyushu University
Nate Heintzman	2002-2007	Graduate student	Scientist, Dexcom
Nate Maynard	2002-2008	Graduate student	Scientist, Synthetic Genomics
Nathan Zemke	2020-2022	Postdoctoral Fellow	Associate Director, UCSD Center for Epigenomics
Nathaniel D. Heintzman	2002-2007	Graduate Student	Director, Data Partnerships, Dexcom,Inc.
Nathaniel Maynard	2002-2008	Graduate Student	Senior Scientist, Synthetic Genomics
Nisha Rajagopal	2009-2013	Graduate Student	Senior Scientist, Syros Pharmaceuticals
Poshen Chen	2018-2022	Postdoctoral Fellow	Assistant Professor, A-STAR and GIS, Singapore
Quan Zhu		Research Scientist	Associate Director, Epigenomics Center at UCSD
R. David Hawkins	2005-2010	Postdoctoral Fellow	Associate Professor, U. Washington, Seattle
Ramya Raviram	2017-2020	Postdoctoral Fellow	Postdoctoral Fellow, Weill Cornell Medical School
Rhona Stuart	2003-2007	Research Associate	Postdoctoral Researcher at Lawrence Livermore National Laboratory
Rong Hu		Research Associate	Beijing, China
Rongxin Fang	2015-2019	Graduate Student	Postdoctoral fellow, Harvard University
Sarah Van Calcar	2001-2006	Research Associate	Assistant Professor of Clinical Medicine, Hospital of the University of Pennsylvania
Saurabh Agarwal	2005-2011	Graduate Student	Postdoc at University of Michigan
Sebastian Preissl	2015-2017	Postdoctoral Fellow	Group leader, University of Freiburg, Germany
Shan Jiang	2019-2020	Postdoctoral Fellow	Research Scientist, AccuraGen
Shan Mandy Jiang	2019-2020	Postdoctoral Fellow	Bioinformatics Scientist, AccuraGen.
Siddarth Selvaraj	2011-2014	Graduate Student	Founder and CEO, Arima Genomics, Inc.
Sora Chee		Research Associate	Medical student
Tae Hoon Kim	2002-2006	Postdoctoral Fellow	Professor and Chair, University of Texas, Dallas
Tingting Du	2008-2015	Postdoctoral Fellow	Oncology Scientist, Illunima
Tristin Liu		Research Associate	Master's student
Wei Xie	2009-2013	Postdoctoral Fellow	Professor and Deputy Dean, School of Life Sciences, Tsinghua University, China
Yan Li	2009-2015	Postdoctoral Fellow	Assistant Professor, Case Western Reserve University
Yang Li	2018-2023	Postdoctoral Fellow	Assistant Professor, Washington University, St Louis
Yanxiao Zhang	2016-2022	Postdoctoral Fellow	Assistant Professor, Westlake University, China
Yarui Diao	2012-2018	Postdoctoral Fellow	Assistant Professor, Duke University
Yin Shen	2008-2014	Postdoctoral Fellow	Associate Professor, UCSF
Yuan Zhao	2015-2019	Graduate Student	Data Scientist, Encoded Therapeutics
Yunjiang Qiu	2014-2019	Graduate Student	Scientist, Illunima
Zirong Li	2002-2007	Postdoctoral Fellow	Scientist, Millipore
