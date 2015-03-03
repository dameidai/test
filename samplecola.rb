require 'open-uri'
require 'nokogiri'

#�X�N���C�s���O���URL
url = 'http://finance.yahoo.com/q/cf?s=KO+Cash+Flow&annual'#�ăR�J�R�[��

charset = nil
html = open(url) do |f|
  charset = f.charset #������ʂ��擾
  f.read #html��ǂݍ���ŕϐ�html�ɓn��
end

#html���p�[�X(���)���ăI�u�W�F�N�g���쐬
doc = Nokogiri::HTML.parse(html, nil, charset)
#���o�������f�[�^�m�[�h�����o��
mainNode = doc.css("table#yfncsumtab")
##���[�v�̍s�������Ȃ�̂ő��
trs = mainNode.css('tr > td > table > tr > td > table > tr')

#���o��̃f�[�^�i�[
cashHash = trs.inject({}) do |hash, tr|

  ##tr.text���󕶎���ł���Ύ��̃��[�v��
  next hash if tr.text.empty?
  p tr.text
  dataAry = tr.css('td').map do |td|
    #�f�[�^�z��ɒǉ�
    data = td.text.gsub(/[\u00A0\n]/, '').strip
  end
  ##�b��I��dataAry[0]�ɓ˂�����ł���keyNm�����o��
  keyNm = dataAry.shift
  #�n�b�V���ɒǉ���ɃL�[�Ŏ��o���Ďg���\��
  hash[keyNm] = dataAry

  hash
end

#�f�[�^�m�F
#cashHash.each do |key, value|
#  puts "---------------------"
#  puts key
#  puts "---------------------"
#  value.each do |data|
#    puts data 
#  end
#end
