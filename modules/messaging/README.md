# Messaging Module

This module creates an Amazon SQS messaging system with a dead-letter queue.

## Resources

The module creates:

- Main SQS queue
- Dead-letter queue
- Redrive policy
- SQS queue policy
- Server-side encryption

## Architecture

```text
Application
     |
     v
  SQS Queue
     |
     | failed messages
     v
    DLQ