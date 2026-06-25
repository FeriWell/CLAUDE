---
name: feedback_no_interruptions
description: "Don't interrupt mid-task — wait 5s for response, if none, continue autonomously"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 283d33c2-e130-446e-97fc-145a29bacfdb
---

Don't interrupt mid-task with tool confirmations or questions. Execute autonomously. If pausing to confirm, wait max 5 seconds — if no response, continue.

**Why:** User explicitly asked to stop interrupting during testing flows and to just keep going.
**How to apply:** During any test/build/install/run sequence, do not pause mid-flow. Complete the full task then report results.
