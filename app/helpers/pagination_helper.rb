module PaginationHelper
  AMOUNT_DEFAULT = 25
  PAGE_DEFAULT = 1

  def paginate_collection(relation)
    amount = params[:amount] || AMOUNT_DEFAULT
    page = params[:page] || PAGE_DEFAULT
    relation.page(page).per(amount)
  end
end
