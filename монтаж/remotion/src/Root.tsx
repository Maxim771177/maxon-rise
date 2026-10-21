import {Composition} from 'remotion';
import {TestText} from './TestText';

export const Root: React.FC = () => (
  <Composition id="TestText" component={TestText} durationInFrames={60} fps={30} width={1280} height={720} />
);
