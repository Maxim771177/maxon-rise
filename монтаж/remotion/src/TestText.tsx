import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';

export const TestText: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const scale = spring({frame, fps, config: {damping: 12}});
  const opacity = interpolate(frame, [0, 10], [0, 1], {extrapolateRight: 'clamp'});
  return (
    <AbsoluteFill style={{background: '#111', justifyContent: 'center', alignItems: 'center'}}>
      <div style={{color: '#fff', fontSize: 120, fontFamily: 'sans-serif', fontWeight: 800, opacity, transform: `scale(${scale})`}}>
        Maxon Rise
      </div>
    </AbsoluteFill>
  );
};
