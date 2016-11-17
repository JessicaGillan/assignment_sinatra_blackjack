module BlackjackHelper
  POINTS = {'J' => 10, 'K' => 10, 'Q' => 10, 'A' => 11 }

  def game_start
    player_cards = [draw_from_deck,draw_from_deck]
    dealer_cards = [draw_from_deck,draw_from_deck]
    save_cards(player_cards,dealer_cards)
  end

  def hit_player
    player_cards = (session["player_cards"] << draw_from_deck)
    dealer_cards = session["dealer_cards"]
    save_cards(player_cards,dealer_cards)
  end

  def get_points(cards)
    cards.map do |card|
      if POINTS[ card[0] ].nil?
        card[0].to_i
      else
        POINTS[ card[0] ]
      end
    end
  end

  def blackjack?(cards)
    sum_points( cards ) == 21
  end

  def busted?(cards)
    sum_points( cards ) > 21
  end

  def sum_points(cards)
    points = get_points(cards)

    ace_i = 0
    while points.inject(:+) > 21 && !!ace_i
      ace_i = points.find_index(11)
      points[ace_i] = 1 unless ace_i.nil?
    end

    points.inject(:+)
  end
end