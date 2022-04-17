namespace :dev do
  desc "Configura ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") do
        %x(rails db:drop)
      end

      show_spinner("Criando BD...") do
        %x(rails db:create)
      end

      show_spinner("Migrando BD...") do
        %x(rails db:migrate)
      end

      %x(rails dev:add_MiningTypes)
      %x(rails dev:add_coins)
      
     

    else
      puts "voce não esta em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Populando DB...")  do
      coins =
      [
        {
          description:"BITCOIN",
          acronym:"BTC",
          url_image:"https://imagensemoldes.com.br/wp-content/uploads/2020/09/Imagem-Dinheiro-Bitcoin-PNG.png",
          mining_type:MiningType.find_by(acronym:"PoW")
        },
        {
          description:"dash",
          acronym:"DASH",
          url_image:"https://w7.pngwing.com/pngs/37/123/png-transparent-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text.png",
          mining_type:MiningType.all.sample
        }
      ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "tipos de mineração"
  task add_MiningTypes: :environment do
    show_spinner("Polulando BD MiningTypes...") do
      mining_types = 
      [
        {
          description: "Proof of Work",
          acronym:"PoW"
        },
        {
          description: "Proof of Stake",
          acronym:"PoS"
        },
        {
          description: "Proof of Capacity",
          acronym: "PoC"
        }
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end





  def show_spinner(msg_start,msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end





