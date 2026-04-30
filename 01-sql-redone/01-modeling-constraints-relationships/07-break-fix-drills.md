# Break Fix Drills

1. Remove `profiles_user_id_unique`, insert a second Ada profile, and explain why profile reads can no longer know which Ada row wins.
2. Remove `saved_listings_pk`, insert Ada saving Ben listing 101 again, and watch the duplicate save become indistinguishable from a real second event.
3. Change `saved_listings_pk` to only `listing_id`, then prove Diya can no longer save Ben listing 101 after Ada.
4. Remove `follows_no_self`, insert Ada following Ada, and explain why a recommendation query would now treat the viewer as an author.
5. Remove `listings_seller_id_fk`, insert listing 999 for seller 999, and show that no user can own the listing in a join.

