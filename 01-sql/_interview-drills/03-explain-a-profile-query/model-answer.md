# Model Answer

I would project only public fields: handle, display name, and counts. Ada's email stays out of the view. I would count posts, followers, and following in separate grouped subqueries so Ada's two posts and two followers do not multiply into four rows.
