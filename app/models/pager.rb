class Pager
  def initialize(model, page, per_page)
    @model = model
    @page = page.to_i
    @per_page = per_page
  end

  def paged
    page_offset = @page * @per_page
    if @model.is_a? Array
      @model.drop(page_offset).take(@per_page)
    else
      @model.offset(page_offset).limit(@per_page)
    end
  end

  def has_previous_step?
    @page > 1
  end

  def has_next_step?
    total_pages = size / @per_page
    total_pages > @page
  end

  protected

  def size
    @size ||= @model.size
  end
end
