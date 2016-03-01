class Pager
  attr_reader :page

  def initialize(model, page, per_page, elasticsearch)
    @model = model
    @page = page.to_i
    @per_page = per_page
    @elasticsearch = elasticsearch
  end

  def paged
    page_offset = (@page - 1) * @per_page
    return @model.offset(page_offset).limit(@per_page) unless @elasticsearch
    @model if @elasticsearch
  end

  def has_previous_step?
    @page > 1
  end

  def has_next_step?
    total_pages = (size.to_f / @per_page).ceil
    total_pages > @page
  end

  protected

  def size
    @size ||= @model.size
  end
end
