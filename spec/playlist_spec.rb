require 'spec_helper'
require_relative '../playlist'
require_relative '../song'

RSpec.describe Playlist do

  let(:it_had_to_be_you) { Song.new('It had to be you', 100) }
  let(:but_not_for_me) { Song.new('But Not for Me', 50) }
  let(:autumn_in_new_york) { Song.new('Autumn In New York', 25) }

  it "is empty by default" do
    playlist = Playlist.new

    expect(playlist.empty?).to eq(true)
  end

  it "allows you to add a song" do
    playlist = Playlist.new
    playlist.add_song(it_had_to_be_you)

    expect(playlist.empty?).to eq(false)
  end

  it "allows you to see all song names in the order they were added" do
    playlist = Playlist.new

    expect(playlist.song_names).to eq([])

    playlist.add_song(it_had_to_be_you)
    expect(playlist.song_names).to eq(['It had to be you'])

    playlist.add_song(but_not_for_me)
     expect(playlist.song_names).to eq([
      'It had to be you',
      'But Not for Me'
      ])
  end

  it "allows you remove a song from the playlist" do
    playlist = Playlist.new

    playlist.add_song(it_had_to_be_you)
    expect(playlist.empty?).to eq(false)

    playlist.add_song(but_not_for_me)

    expect(playlist.song_names).to eq([
      'It had to be you',
      'But Not for Me',
    ])

    playlist.remove_song(it_had_to_be_you)
    expect(playlist.song_names).to eq([
      'But Not for Me',
    ])
    expect(playlist.empty?).to eq(false)

    playlist.remove_song(but_not_for_me)

    expect(playlist.song_names).to eq([])
    expect(playlist.empty?).to eq(true)
  end

  it "tells you the total length of the playlist"  do
    playlist = Playlist.new

    playlist.add_song(it_had_to_be_you)
    expect(playlist.total_length).to eq(100)

    playlist.add_song(but_not_for_me)
    playlist.add_song(autumn_in_new_york)
    expect(playlist.total_length).to eq(175)
  end

  it("allows you to swap songs") do
    playlist = Playlist.new

    playlist.add_song(it_had_to_be_you)
    playlist.add_song(but_not_for_me)
    playlist.add_song(autumn_in_new_york)

    playlist.swap(it_had_to_be_you, but_not_for_me)
    expect(playlist.song_names).to eq([
      'But Not for Me',
      'It had to be you',
      'Autumn In New York'
    ])

    playlist.swap(it_had_to_be_you, autumn_in_new_york)
    expect(playlist.song_names).to eq([
      'But Not for Me',
      'Autumn In New York',
      'It had to be you'
    ])
  end

  it "allows you to play a song"  do
    playlist = Playlist.new
    playlist.add_song(it_had_to_be_you)
    playlist.add_song(but_not_for_me)
    playlist.add_song(autumn_in_new_york)

    expect(playlist.now_playing).to eq(nil)

    playlist.play

    expect(playlist.now_playing).to eq(it_had_to_be_you);
  end

  it "allows you go to the next song" do
    playlist = Playlist.new
    playlist.add_song(it_had_to_be_you)
    playlist.add_song(but_not_for_me)
    playlist.add_song(autumn_in_new_york)

    playlist.play
    playlist.next
    expect(playlist.now_playing).to eq(but_not_for_me)

    playlist.next
    expect(playlist.now_playing).to eq(autumn_in_new_york)

    playlist.next
    expect(playlist.now_playing).to eq(nil)
  end

end
