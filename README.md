# Oystercard

### Purpose

A mini project designed to recreate the London Underground oystercard system, allowing a user to touch in and out at stations, log and view their travel history.

### User Stories

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```

### Technology Used

* Ruby
* RSpec, for testing

### Set Up Instructions

1. Fork this repo
2. Run `bundle` to ensure all required gems

### How to Use

* Require file in REPL

```
ᚹᚱᛘ ᛬ require './lib/oystercard'
=> true
```

* Create a new Oystercard, and top up (here I top up with £20)

```
ᚹᚱᛘ ᛬ o = Oystercard.new
=> #<Oystercard:0x007fd01b26b1a8 @balance=0, @journey=#<Journey:0x007fd01b26b180 @journey_history=[], @single_journey={}>>
ᚹᚱᛘ ᛬ o.top_up(20)
=> 20
```

* Create some test stations, assigning them a name (as a string), and zone (as an integer)
```
ᚹᚱᛘ ᛬ bank = Station.new("Bank", 1)
=> #<Station:0x007f9b50a409a0 @name="Bank", @zone=1>
ᚹᚱᛘ ᛬ hammersmith = Station.new("Hammersmith", 4)
=> #<Station:0x007f9b509701b0 @name="Hammersmith", @zone=4>
ᚹᚱᛘ ᛬ ruislip = Station.new("Ruislip", 6)
=> #<Station:0x007f9b508e9e30 @name="Ruislip", @zone=6>
```

* Re-create a typical journey (touch in & touch out). Fare is calculated using zones travelled (£1 for every journey, plus £1 for every zone boundary crossed). In this case, the fare is £4.
```
ᚹᚱᛘ ᛬ o.touch_in(bank)
=> #<Station:0x007f9b50a409a0 @name="Bank", @zone=1>
ᚹᚱᛘ ᛬ o.touch_out(hammersmith)
=> 16
```

* Re-create an incomplete journey, where the user does not touch in. In this case, a penalty charge of £6 is charged.
```
ᚹᚱᛘ ᛬ o.touch_out(ruislip)
=> 10
```

* View journey history to see complete and incomplete journey
```
ᚹᚱᛘ ᛬ o.journey
=> #<Journey:0x007f9b50b446d0
 @journey_history=
  [{:entry_station=>#<Station:0x007f9b50a409a0 @name="Bank", @zone=1>, :exit_station=>#<Station:0x007f9b509701b0 @name="Hammersmith", @zone=4>},
   {:exit_station=>#<Station:0x007f9b508e9e30 @name="Ruislip", @zone=6>, :entry_station=>"No touch in"}],
```

### Outstanding Features

The program currently does not support an incomplete journey when a user touches in twice, as journey is assessed for "completeness" only on touch out. Potential to implement a timeout feature to catch this edge case.
