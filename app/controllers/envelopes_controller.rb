class EnvelopesController < ApplicationController
  def create
    amount=Input.amount(params[:allocation_minor],10_000_000)
    row=Envelope.create!(name:Input.text(params[:name]),allocation_minor:amount,remaining_minor:amount)
    render json:serialize(row),status: :created
  end
  def show = render(json:serialize(Envelope.find(params[:id])))
  def spend
    amount=Input.amount(params[:amount_minor]);reference=Input.id(params[:reference]);row=Envelope.find(params[:id])
    row.with_lock do
      remaining=Input.remaining!(row.remaining_minor,amount)
      row.spends.create!(reference:reference,amount_minor:amount);row.update!(remaining_minor:remaining)
    end
    render json:serialize(row),status: :created
  end
  private
  def serialize(row) = row.as_json(only:[:id,:name,:allocation_minor,:remaining_minor])
end
