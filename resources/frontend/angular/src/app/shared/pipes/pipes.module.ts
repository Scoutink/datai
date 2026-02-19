import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TruncatePipe } from './truncate.pipe';
import { ReminderFrequencyPipe } from './reminder-frequency.pipe';
import { UTCToLocalTime } from './utc-to-localtime.pipe';
import { RetentionActionPipe } from './retention-action.pipe';
import { SafePipe } from './safe.pipe';

@NgModule({
  declarations: [TruncatePipe, ReminderFrequencyPipe, UTCToLocalTime, RetentionActionPipe, SafePipe],
  imports: [CommonModule],
  exports: [TruncatePipe, ReminderFrequencyPipe, UTCToLocalTime, RetentionActionPipe, SafePipe],
})
export class PipesModule { }
