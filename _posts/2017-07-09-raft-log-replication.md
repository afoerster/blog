---
layout: post
title:  "Raft Log Replication, Simply"
date:   2017-07-09 12:42:29 -0500
categories: kudu replication consensus

---

The [Raft consensus protocol](https://raft.github.io/raft.pdf) is used to create replicated state machines. The state machines can be played from a log, where each record in the log is a command for the state machine. This log is replicated across multiple nodes. By replaying this log, the state machines can each reach the same state.

Raft assumes a single leader. All requests are served through this leader. If a follower receives a request, it will route the request back to the leader. When a request is received by the leader, the leader appends records to its own log, then send append requests to followers.

The append request contains at least:
- term number
- previous log entry index
- state machine command

The follower will compare the previous log entry index and term with it's last committed log entry as a consistency check. If the previous log entry does match, the follower is out of sync it must rewind its own log and replicate the records from the leader. 

Append requests are sent asynchronously to followers. Once a majority of followers have acknowledged the log message, the leader will commit the message. The leader keeps track of the last committed message and will communicate this to the followers. Once a follower learns that a log record was committed, it will apply the command to its own state machine.






