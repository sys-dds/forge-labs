#!/usr/bin/env bash
set -euo pipefail
root="04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns"
fail(){ echo "FAIL BIP PIM quality: $*" >&2; exit 1; }
[[ -f "04-backend-interview-patterns-redone/README.md" ]] || fail "missing track README"
for f in README.md 00-how-to-study.md 00-product-interaction-pattern-map.md 00-common-data-modeling-traps.md 00-objects-relationships-events-read-models.md 00-feed-notification-activity-patterns.md 00-recommendation-candidate-basics.md 00-read-models-and-counters.md 00-visibility-and-user-controls.md 00-safety-moderation-trust-patterns.md 00-policy-decision-and-audit-lineage.md 00-marketplace-creator-ecosystem-patterns.md 00-buyer-intent-seller-quality-and-supply-demand.md 00-messaging-inbox-communication-patterns.md 00-groups-communities-memberships-patterns.md 00-discovery-search-topics-collections-patterns.md; do [[ -s "$root/$f" ]] || fail "missing $root/$f"; done
[[ -f infra/docker-compose/docker-compose.postgres.yml ]] || fail "missing Docker/Postgres compose"
for s in bip-pim-list.sh bip-pim-test-one.sh bip-pim-test-all.sh check-bip-pim-quality.sh; do [[ -x "scripts/$s" ]] || fail "missing executable scripts/$s"; done
required=(README.md 00-interview-question.md 01-data-model.md 02-schema.sql 03-seed.sql 03b-seed-variant.sql 04-core-queries.sql 05-verification-query.sql 06-expected-output.csv 06b-expected-output-variant.csv 07-broken-model-or-query.sql 08-proof.sh 09-api-shape.md 10-read-write-path.md 11-scaling-notes.md 12-common-mistakes.md 13-how-to-explain-in-interview.md 14-shortcut-audit.md)
count=0
for clinic in "$root"/[0-9][0-9][0-9]-*; do
  [[ -d "$clinic" ]] || continue; count=$((count+1))
  for f in "${required[@]}"; do [[ -s "$clinic/$f" ]] || fail "missing or empty $clinic/$f"; done
  [[ -x "$clinic/08-proof.sh" ]] || fail "$clinic/08-proof.sh not executable"
  [[ "$(head -n 1 "$clinic/06-expected-output.csv")" == *,* ]] || fail "$clinic expected CSV missing header"
  [[ "$(wc -l < "$clinic/06-expected-output.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic expected CSV empty"
  [[ "$(wc -l < "$clinic/06b-expected-output-variant.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic variant expected CSV empty"
  if cmp -s "$clinic/05-verification-query.sql" "$clinic/07-broken-model-or-query.sql"; then fail "$clinic broken query identical to verification"; fi
  if grep -Eiq "where[[:space:][:alnum:]_\.]*_id[[:space:]]+in[[:space:]]*\(|order[[:space:]]+by[[:space:]]+case[[:space:]][[:alnum:]_\.]*_id|expected_output|expected-output|create[[:space:]]+(temporary[[:space:]]+|temp[[:space:]]+)?table[[:space:]]+(answer|expected|result)|from[[:space:]]+(answer|expected|result)" "$clinic/05-verification-query.sql"; then fail "$clinic verification contains shortcut pattern"; fi
  if grep -Eiq "select[[:space:]]+'[^']+'[[:space:]]+as[[:space:]]+contract_name[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]+as[[:space:]]+subject_id[[:space:]]*,[[:space:]]*'[^']+'" "$clinic/05-verification-query.sql"; then fail "$clinic verification emits literal answer rows"; fi
  if grep -Eiq "values[[:space:]]*\\([[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'|union[[:space:]]+all[[:space:]]+select[[:space:]]+'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'" "$clinic/05-verification-query.sql"; then fail "$clinic verification builds final answer from literal rows"; fi
  grep -qi "Actual tables" "$clinic/01-data-model.md" || fail "$clinic data model missing actual tables"
  grep -qi "Trap rows" "$clinic/01-data-model.md" || fail "$clinic data model missing trap rows"
  grep -qi "Constraints" "$clinic/01-data-model.md" || fail "$clinic data model missing constraints"
  grep -qi "Write path" "$clinic/10-read-write-path.md" || fail "$clinic missing write path"
  grep -qi "Read path" "$clinic/10-read-write-path.md" || fail "$clinic missing read path"
  grep -qi "Direct answer" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic missing interview direct answer"
  clinic_name="$(basename "$clinic")"; clinic_num="${clinic_name%%-*}"
  if [[ "$((10#$clinic_num))" -ge 6 && "$((10#$clinic_num))" -lt 21 ]]; then
    grep -Eiq "users|profiles|follow_edges|block_edges|posts|comments|swipe_events|matches|notifications|activity_events|user_interests" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing actual table names"
    grep -Eiq "[0-9]{3,4}|Ada|Ben|Cy|Eli|Diya|Hana|Ivan|Omar|Noor|Lina" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing actual trap rows"
  fi
  if [[ "$((10#$clinic_num))" -ge 16 && "$((10#$clinic_num))" -lt 21 ]]; then
    grep -Eiq "evidence|decision|treatment|appeal|audit|component|trace|queue" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic safety explanation missing lineage details"
    if grep -Rqi "trust score" "$clinic" && ! grep -Rqi "component" "$clinic"; then fail "$clinic has opaque trust score without components"; fi
    grep -Eiq "evidence|treatment|component|trace|audit" "$clinic/05-verification-query.sql" || fail "$clinic safety verification lacks evidence/treatment/component trace"
  fi
  if [[ "$((10#$clinic_num))" -ge 21 && "$((10#$clinic_num))" -lt 26 ]]; then
    grep -Eiq "buyers|sellers|creators|listings|offers|bookings|seller_quality_components|buyer_intents|exposure_budget_windows|marketplace_treatments" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic marketplace explanation missing actual table names"
    grep -Eiq "Ada|MegaMaker|QuietCraft|RiskSeller|listing 101|offer 301|booking 401|risk event 1701|[0-9]{3,4}" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic marketplace explanation missing actual trap rows"
    if grep -Rqi "seller_quality_score" "$clinic" && ! grep -Rqi "component" "$clinic"; then fail "$clinic has opaque seller_quality_score without components"; fi
    if grep -Rqi "creator_exposure_score" "$clinic" && ! grep -Rqi "budget\\|trace" "$clinic"; then fail "$clinic has opaque creator_exposure_score without budget/trace rows"; fi
    grep -Eiq "component|budget|trace|treatment|intent|availability|supply|demand" "$clinic/05-verification-query.sql" || fail "$clinic marketplace verification lacks component/budget/treatment trace"
  fi
  if [[ "$((10#$clinic_num))" -ge 26 && "$((10#$clinic_num))" -lt 31 ]]; then
    grep -Eiq "conversations|conversation_participants|messages|message_delivery_states|message_read_receipts|message_deletions|conversation_user_settings|message_reports|review_queue_items" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic communication explanation missing actual table names"
    grep -Eiq "Ada|Ben|Cy|Diya|message 1001|message 1002|message 1003|report 7001|read receipt 4001|[0-9]{3,4}" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic communication explanation missing actual trap rows"
    grep -Eiq "read_receipt|message_read_receipts|latest_read|delete_scope|message_deletions|conversation_user_settings|sent_rank|ORDER BY .*conversation_id|report|review_queue" "$clinic/05-verification-query.sql" || fail "$clinic communication verification lacks per-user read/delete/inbox/report trace"
  fi
  if [[ "$((10#$clinic_num))" -ge 31 && "$((10#$clinic_num))" -lt 36 ]]; then
    grep -Eiq "communities|community_memberships|community_roles|community_role_assignments|community_permissions|community_join_requests|community_invites|community_bans|community_channels|channel_memberships|community_posts|community_threads|community_post_moderation_actions|community_events|event_rsvps|event_waitlist|event_attendance|community_audit_log|community_request_audit|event_audit_log" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic community explanation missing actual table names"
    grep -Eiq "Ada|Ben|Cy|Diya|Eli|membership 1003|membership 2002|request 2001|request 3003|invite 4004|ban 5004|ban 7001|channel membership 5002|post 1004|post 8003|RSVP 3005|attendance 5001|audit row 11003|[0-9]{3,5}" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic community explanation missing actual trap rows"
    grep -Eiq "community_memberships" "$clinic/02-schema.sql" || fail "$clinic has no membership table"
    if [[ "$clinic_num" == "031" || "$clinic_num" == "035" ]]; then
      grep -Eiq "community_roles|community_role_assignments|community_permissions" "$clinic/02-schema.sql" || fail "$clinic has no role permission model"
    fi
    if grep -Eiq "is_admin|global_admin" "$clinic/02-schema.sql" "$clinic/03-seed.sql" "$clinic/03b-seed-variant.sql" "$clinic/05-verification-query.sql"; then fail "$clinic appears to use a global-only community role flag"; fi
    if grep -Rqi "community.visibility = 'public'" "$clinic" && ! grep -Rqi "community_memberships\\|community_invites\\|community_join_requests" "$clinic/05-verification-query.sql"; then fail "$clinic private visibility lacks membership/invite/join-request check"; fi
    if grep -Rqi "event_attendance\\|event_rsvps" "$clinic"; then
      grep -Rqi "event_rsvps" "$clinic" || fail "$clinic event attendance has no RSVP lifecycle"
      grep -Rqi "going\\|maybe\\|declined\\|waitlisted" "$clinic" || fail "$clinic event attendance lacks RSVP states"
    fi
    if grep -Rqi "moderation" "$clinic"; then
      grep -Rqi "actor_user_id\\|audit" "$clinic" || fail "$clinic moderation model lacks actor/audit trace"
    fi
    grep -Eiq "membership|role|permission|request|invite|private|channel|post|moderation|audit|rsvp|waitlist|attendance|trace" "$clinic/05-verification-query.sql" || fail "$clinic community verification lacks contract trace"
  fi
  if [[ "$((10#$clinic_num))" -ge 36 && "$((10#$clinic_num))" -lt 41 ]]; then
    grep -Eiq "topics|hashtags|content_topic_links|creator_topic_links|user_topic_follows|search_queries|search_sessions|search_filters|search_facets|saved_searches|trend_windows|trend_signal_components|trend_snapshots|collections|collection_members|collection_items|saved_items|policy_treatments|abuse_signal_events" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic discovery explanation missing actual table names"
    grep -Eiq "Ada|Ben|Cy|Diya|hashtag 301|filter 2001|saved search 4002|treatment 7001|collection item 5003|filter 9101|saved search 9202|treatment 16001|item 13003|[0-9]{3,5}" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic discovery explanation missing actual trap rows"
    if grep -Rqi "trend_score" "$clinic" && ! grep -Rqi "trend_signal_components" "$clinic"; then fail "$clinic has opaque trend_score without trend components"; fi
    if grep -Rqi "search_queries" "$clinic"; then
      grep -Rqi "search_filters" "$clinic" || fail "$clinic search query has no filter modeling"
      grep -Rqi "search_facets" "$clinic" || fail "$clinic search query has no facet modeling"
      grep -Rqi "saved_searches" "$clinic" || fail "$clinic search query has no saved-search modeling"
    fi
    if grep -Rqi "collections" "$clinic"; then
      grep -Rqi "owner_user_id" "$clinic/02-schema.sql" || fail "$clinic collection model lacks owner"
      grep -Rqi "visibility" "$clinic/02-schema.sql" || fail "$clinic collection model lacks visibility"
      grep -Rqi "collection_items" "$clinic/02-schema.sql" || fail "$clinic collection model lacks item lifecycle"
    fi
    if [[ "$clinic_num" == "038" || "$clinic_num" == "040" ]]; then
      grep -Rqi "trend_signal_components" "$clinic" || fail "$clinic trend model lacks component rows"
      grep -Eiq "velocity|unique_actor|freshness|component|treatment|suppressed|trace" "$clinic/05-verification-query.sql" || fail "$clinic trend verification lacks component/suppression trace"
    fi
    grep -Eiq "topic|hashtag|filter|facet|saved|trend|component|suppression|collection|visibility|lifecycle|trace" "$clinic/05-verification-query.sql" || fail "$clinic discovery verification lacks contract trace"
  fi
  grep -qi "variant proof catches" "$clinic/14-shortcut-audit.md" || fail "$clinic shortcut audit missing variant proof"
  grep -qi "mutation should fail" "$clinic/14-shortcut-audit.md" || fail "$clinic shortcut audit missing mutation"
  if grep -Riq "this clinic teaches product modeling\|TODO\|lorem ipsum" "$clinic"; then fail "$clinic contains placeholder wording"; fi
done
[[ "$count" -eq 40 ]] || fail "expected 40 clinics, found $count"
if find "$root" -maxdepth 1 -type d -name '041-*' | grep -q .; then fail "unexpected clinics beyond 040"; fi
for n in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040; do
  ./scripts/bip-pim-list.sh | grep -q "/$n-" || fail "all-test list must include $n"
done
[[ "$(./scripts/bip-pim-list.sh | wc -l | tr -d ' ')" -eq 40 ]] || fail "all-test list must include exactly 001-040"
if rg -n "Spring|JPA|Redis|Kafka|sklearn|numpy|pandas|notebook|\.ipynb|OpenSearch" "$root" scripts/bip-pim-*.sh; then fail "out-of-scope addition found"; fi
echo "PASS BIP PIM quality gate"
