module Biz
  class KaifuQueryApi
    


    def get_mab(js)
      mab = ''
      js.keys.sort.each {|k| mab << js[k] if k != :mac && js[k] }
      mab
    end
    def get_md5_mac(mab, key)
      Digest::MD5.hexdigest(mab + key).upcase
    end
  end
end
